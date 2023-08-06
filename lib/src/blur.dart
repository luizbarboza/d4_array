import 'dart:math';

/// Blurs an list of [data] in-place by applying three iterations of a moving
/// average transform, for a fast approximation of a gaussian kernel of the
/// given [radius], a non-negative number, and returns the list.
///
/// ```dart
/// final randomWalk = cumsumBy(List.filled(1000, null), (_) => Random().nextInt(1) - 0.5);
/// blur(List.castFrom(randomWalk), 5);
/// ```
///
/// Copy the data if you don’t want to smooth it in-place:
///
/// ```dart
/// final smoothed = blur(List.castFrom(randomWalk.sublist(0)), 5);
/// ```
///
/// {@category Blurring data}
List<double> blur(List<double> data, num radius) {
  if (!(radius >= 0)) throw RangeError("invalid r");
  var length = data.length;
  if (!(length >= 0)) throw RangeError("invalid length");
  if (length == 0 || radius == 0) return data;
  final blur = _blurf(radius);
  final temp = data.toList();
  blur(data, temp, 0, length, 1);
  blur(temp, data, 0, length, 1);
  blur(data, temp, 0, length, 1);
  return data;
}

/// Blurs a matrix of the given width and height in-place, by applying an
/// horizontal blur of radius [rx] and a vertical blur or radius [ry] (which
/// defaults to [rx]).
///
/// The matrix [data] is stored in a flat list, used to determine the height if
/// it is not specified. Returns the blurred [data].
///
/// ```dart
/// var data = <double>[
///   1, 0, 0,
///   0, 0, 0,
///   0, 0, 1
/// ];
/// blur2((data: data, width: 3, height: null), 1);
/// ```
///
/// {@category Blurring data}
({List<double> data, int width, int? height}) blur2(
        ({List<double> data, int width, int? height}) data, int rx,
        [int? ry]) =>
    _blur2(_blurf)(data, rx, ry);

/// Blurs an [ImageData](https://developer.mozilla.org/en-US/docs/Web/API/ImageData)
/// structure in-place, blurring each of the RGBA layers independently by
/// applying an horizontal blur of radius [rx] and a vertical blur or radius
/// [ry] (which defaults to [rx]). Returns the blurred ImageData.
///
/// {@category Blurring data}
({List<double> data, int width, int? height}) blurImage(
        ({List<double> data, int width, int? height}) data, int rx,
        [int? ry]) =>
    _blur2(_blurfImage)(data, rx, ry);

({List<double> data, int width, int? height}) Function(
        ({List<double> data, int width, int? height}), int, [int?])
    _blur2(
        void Function(List<double>, List<double>, int, int, int) Function(num)
            blur) {
  return (data, rx, [ry]) {
    ry ??= rx;
    if (!(rx >= 0)) throw RangeError("invalid rx");
    if (!(ry >= 0)) throw RangeError("invalid ry");
    var (data: values, width: width, height: height) = data;
    if (!(width >= 0)) throw RangeError("invalid width");
    if (!((height ??= values.length ~/ width) >= 0)) {
      throw RangeError("invalid height");
    }
    if (width == 0 || height == 0 || (rx == 0 && ry == 0)) return data;
    final blurx = rx != 0 ? blur(rx) : null;
    final blury = ry != 0 ? blur(ry) : null;
    final temp = values.toList();
    if (blurx != null && blury != null) {
      _blurh(blurx, temp, values, width, height);
      _blurh(blurx, values, temp, width, height);
      _blurh(blurx, temp, values, width, height);
      _blurv(blury, values, temp, width, height);
      _blurv(blury, temp, values, width, height);
      _blurv(blury, values, temp, width, height);
    } else if (blurx != null) {
      _blurh(blurx, values, temp, width, height);
      _blurh(blurx, temp, values, width, height);
      _blurh(blurx, values, temp, width, height);
    } else if (blury != null) {
      _blurv(blury, values, temp, width, height);
      _blurv(blury, temp, values, width, height);
      _blurv(blury, values, temp, width, height);
    }
    return data;
  };
}

void _blurh(void Function(List<double>, List<double>, int, int, int) blur,
    List<double> T, List<double> S, int w, int h) {
  for (var y = 0, n = w * h; y < n;) {
    blur(T, S, y, y += w, 1);
  }
}

void _blurv(void Function(List<double>, List<double>, int, int, int) blur,
    List<double> T, List<double> S, int w, int h) {
  for (var x = 0, n = w * h; x < w; ++x) {
    blur(T, S, x, x + n, w);
  }
}

void Function(List<double>, List<double>, int, int, int) _blurfImage(
    num radius) {
  final blur = _blurf(radius);
  return (T, S, start, stop, step) {
    start <<= 2;
    stop <<= 2;
    step <<= 2;
    blur(T, S, start + 0, stop + 0, step);
    blur(T, S, start + 1, stop + 1, step);
    blur(T, S, start + 2, stop + 2, step);
    blur(T, S, start + 3, stop + 3, step);
  };
}

// Given a target array T, a source array S, sets each value T[i] to the average
// of {S[i - r], …, S[i], …, S[i + r]}, where r = ⌊radius⌋, start <= i < stop,
// for each i, i + step, i + 2 * step, etc., and where S[j] is clamped between
// S[start] (inclusive) and S[stop] (exclusive). If the given radius is not an
// integer, S[i - r - 1] and S[i + r + 1] are added to the sum, each weighted
// according to r - ⌊radius⌋.
void Function(List<double>, List<double>, int, int, int) _blurf(num radius) {
  final radius0 = radius.floor();
  if (radius0 == radius) return _bluri(radius0);
  final t = radius - radius0;
  final w = 2 * radius + 1;
  return (T, S, start, stop, step) {
    // stop must be aligned!
    if (!((stop -= step) >= start)) return; // inclusive stop
    var sum = radius0 * S[start];
    final s0 = step * radius0;
    final s1 = s0 + step;
    for (var i = start, j = start + s0; i < j; i += step) {
      sum += S[min(stop, i)];
    }
    for (var i = start, j = stop; i <= j; i += step) {
      sum += S[min(stop, i + s0)];
      T[i] = (sum + t * (S[max(start, i - s1)] + S[min(stop, i + s1)])) / w;
      sum -= S[max(start, i - s0)];
    }
  };
}

// Like blurf, but optimized for integer radius.
void Function(List<double>, List<double>, int, int, int) _bluri(int radius) {
  final w = 2 * radius + 1;
  return (T, S, start, stop, step) {
    // stop must be aligned!
    if (!((stop -= step) >= start)) return; // inclusive stop
    var sum = radius * S[start];
    final s = step * radius;
    for (var i = start, j = start + s; i < j; i += step) {
      sum += S[min(stop, i)];
    }
    for (var i = start, j = stop; i <= j; i += step) {
      sum += S[min(stop, i + s)];
      T[i] = sum / w;
      sum -= S[max(start, i - s)];
    }
  };
}
