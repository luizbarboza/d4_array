/// Returns an list containing an arithmetic progression, similar to the Python
/// built-in [range](http://docs.python.org/library/functions.html#range).
///
/// This method is often used to iterate over a sequence of uniformly-spaced
/// numeric values, such as the indexes of an list or the ticks of a linear
/// scale. (See also [ticks] for nicely-rounded values.)
///
/// If [step] is omitted, it defaults to 1. If [start] is omitted, it defaults
/// to 0. The [stop] value is exclusive; it is not included in the result. If
/// [step] is positive, the last element is the largest [start] + *i* * [step]
/// less than [stop]; if [step] is negative, the last element is the smallest
/// [start] + *i* * [step] greater than [stop]. If the returned list would
/// contain an infinite number of values, an empty range is returned.
///
/// The arguments are not required to be integers; however, the results are more
/// predictable if they are. The values in the returned list are defined as
/// [start] + *i* * [step], where *i* is an integer from zero to one minus the
/// total number of elements in the returned list. For example:
///
/// ```dart
/// range(start: 0, stop: 1, step: 0.2); // [0, 0.2, 0.4, 0.6000000000000001, 0.8]
/// ```
///
/// This unexpected behavior is due to IEEE 754 double-precision floating point,
/// which defines 0.2 * 3 = 0.6000000000000001. Use d4_format to format numbers
/// for human consumption with appropriate rounding; see also linear.tickFormat
/// in d4_scale.
///
/// Likewise, if the returned list should have a specific length, consider using
/// [List.map] on an integer range. For example:
///
/// ```dart
/// range(start: 0, stop: 1, step: 1 / 49); // BAD: returns 50 elements!
/// range(stop: 49).map((d) => d / 49); // GOOD: returns 49 elements.
/// ```
///
/// {@category Ticks}
List<num> range({num start = 0, required num stop, num step = 1}) {
  var n = ((stop - start) / step).ceilToDouble();

  if (!n.isFinite || n.isNegative) n = 0;

  return List.generate(n.truncate(), (i) => (start + i * step));
}
