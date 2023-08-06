import 'ascending.dart';
import 'min.dart';

/// Returns the least of all values in the [iterable] according to the specified
/// [comparator].
///
/// If the given [iterable] contains no comparable values (i.e., the comparator
/// returns [double.nan] when comparing each value to itself), returns `null`.
///
/// If [comparator] is not specified, it defaults to [ascending]. For example:
///
/// ```dart
/// const array = [
///   {"foo": 42},
///   {"foo": 91}
/// ];
/// least(array, (a, b) => a["foo"]! - b["foo"]!); // {foo: 42}
/// least(array, (a, b) => b["foo"]! - a["foo"]!); // {foo: 91}
/// ```
///
/// This function is similar to [min], except that it accepts an iterable of
/// values ​​that do not implement the [Comparable] interface.
///
/// {@category Summarizing data}
T? least<T>(Iterable<T> iterable, [num Function(T, T) comparator = ascending]) {
  T? max;
  var defined = false;
  for (final value in iterable) {
    if (defined
        ? comparator(value, max as T) < 0
        : comparator(value, value) == 0) {
      max = value;
      defined = true;
    }
  }
  return max;
}

/// Returns the element with the least of all values yielded by the [accessor]
/// function applied to each element in the [iterable] according to the
/// specified [comparator].
///
/// If the given [iterable] contains no elements that yield comparable values
/// (i.e., the comparator returns [double.nan] when comparing each value to
/// itself), returns `null`.
///
/// If [comparator] is not specified, it defaults to [ascending]. For example:
///
/// ```dart
/// const array = [
///   {"foo": 42},
///   {"foo": 91}
/// ];
/// leastBy(array, (a) => a["foo"]!); // {foo: 42}
/// ```
///
/// This function is similar to [minBy], except that it accepts an iterable of
/// elements that yield values ​​that do not implement the [Comparable] interface
/// and returns the value yielded by the [accessor] function.
///
/// {@category Summarizing data}
T? leastBy<T, R>(Iterable<T> iterable, R Function(T) accessor,
    [num Function(R, R) comparator = ascending]) {
  T? max;
  R? maxValue;
  var defined = false;
  for (final element in iterable) {
    final value = accessor(element);
    if (defined
        ? comparator(value, maxValue as R) < 0
        : comparator(value, value) == 0) {
      max = element;
      maxValue = value;
      defined = true;
    }
  }
  return max;
}
