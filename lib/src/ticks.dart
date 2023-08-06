import 'dart:math';

final _e10 = sqrt(50), _e5 = sqrt(10), _e2 = sqrt(2);

(num, num, num) _tickSpec(num start, num stop, num count) {
  final step = (stop - start) / max(0, count),
      power = (log(step) / ln10).floorToDouble(),
      error = step / pow(10, power),
      factor = error >= _e10
          ? 10
          : error >= _e5
              ? 5
              : error >= _e2
                  ? 2
                  : 1;
  num i1, i2, inc;
  if (power < 0) {
    inc = pow(10, -power) / factor;
    i1 = (start * inc).roundToDouble();
    i2 = (stop * inc).roundToDouble();
    if (i1 / inc < start) ++i1;
    if (i2 / inc > stop) --i2;
    inc = -inc;
  } else {
    inc = pow(10, power) * factor;
    i1 = (start / inc).roundToDouble();
    i2 = (stop / inc).roundToDouble();
    if (i1 * inc < start) ++i1;
    if (i2 * inc > stop) --i2;
  }
  if (i2 < i1 && 0.5 <= count && count < 2) {
    return _tickSpec(start, stop, count * 2);
  }
  return (i1, i2, inc);
}

/// Returns an list of approximately [count] + 1 uniformly-spaced,
/// nicely-rounded values between [start] and [stop] (inclusive).
///
/// Each value is a power of ten multiplied by 1, 2 or 5. See also
/// [tickIncrement], [tickStep] and linear.ticks.
///
/// Ticks are inclusive in the sense that they may include the specified [start]
/// and [stop] values if (and only if) they are exact, nicely-rounded values
/// consistent with the inferred [tickStep]. More formally, each returned tick
/// *t* satisfies [start] ≤ *t* and *t* ≤ [stop].
///
/// {@category Ticks}
List<num> ticks(num start, num stop, num count) {
  if (!(count > 0)) return [];
  if (start == stop) return [start];
  final reverse = stop < start;
  var (i1, i2, inc) =
      (reverse ? _tickSpec(stop, start, count) : _tickSpec(start, stop, count));
  if (!(i2 >= i1)) return [];
  final n = i2 - i1 + 1;
  if (reverse) {
    if (inc < 0) {
      return [for (var i = 0; i < n; ++i) (i2 - i) / -inc];
    } else {
      return [for (var i = 0; i < n; ++i) (i2 - i) * inc];
    }
  } else {
    if (inc < 0) {
      return [for (var i = 0; i < n; ++i) (i1 + i) / -inc];
    } else {
      return [for (var i = 0; i < n; ++i) (i1 + i) * inc];
    }
  }
}

/// Like [tickStep], except requires that [start] is always less than or equal
/// to [stop], and if the tick step for the given [start], [stop] and [count]
/// would be less than one, returns the negative inverse tick step instead.
///
/// This method is always guaranteed to return an integer, and is used by
/// [ticks] to guarantee that the returned tick values are represented as
/// precisely as possible in IEEE 754 floating point.
///
/// {@category Ticks}
num tickIncrement(num start, num stop, num count) {
  return _tickSpec(start, stop, count).$3;
}

/// Returns the difference between adjacent tick values if the same arguments
/// were passed to [ticks]\: a nicely-rounded value that is a power of ten
/// multiplied by 1, 2 or 5.
///
/// Note that due to the limited precision of IEEE 754 floating point, the
/// returned value may not be exact decimals; use d4_format to format numbers
/// for human consumption.
///
/// {@category Ticks}
num tickStep(num start, num stop, num count) {
  final reverse = stop < start,
      inc = reverse
          ? tickIncrement(stop, start, count)
          : tickIncrement(start, stop, count);
  return (reverse ? -1 : 1) * (inc < 0 ? 1 / -inc : inc);
}
