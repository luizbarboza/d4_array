import 'ascending.dart';
import 'max.dart';

/// Returns the greatest of all values in the [iterable] according to the
/// specified [comparator].
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
/// greatest(array, (a, b) => a["foo"]! - b["foo"]!); // {foo: 91}
/// greatest(array, (a, b) => b["foo"]! - a["foo"]!); // {foo: 42}
/// ```
///
/// This function is similar to [max], except that it accepts an iterable of
/// values ​​that do not implement the [Comparable] interface.
///
/// {@category Summarizing data}
T? greatest<T>(Iterable<T> iterable,
    [num Function(T, T) comparator = ascending]) {
  T? max;
  var defined = false;
  for (final value in iterable) {
    if (defined
        ? comparator(value, max as T) > 0
        : comparator(value, value) == 0) {
      max = value;
      defined = true;
    }
  }
  return max;
}

/// Returns the element with the greatest of all values yielded by the [accessor]
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
/// greatestBy(array, (a) => a["foo"]!); // {foo: 91}
/// ```
///
/// This function is similar to [maxBy], except that it accepts an iterable of
/// elements that yield values ​​that do not implement the [Comparable] interface
/// and returns the value yielded by the [accessor] function.
///
/// {@category Summarizing data}
T? greatestBy<T, R>(Iterable<T> iterable, R Function(T) accessor,
    [num Function(R, R) comparator = ascending]) {
  T? max;
  R? maxValue;
  var defined = false;
  for (final value in iterable) {
    final result = accessor(value);
    if (defined
        ? comparator(result, maxValue as R) > 0
        : comparator(result, result) == 0) {
      max = value;
      maxValue = result;
      defined = true;
    }
  }
  return max;
}
