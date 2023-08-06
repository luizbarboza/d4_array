import 'ascending.dart';
import 'max_index.dart';

/// Returns the index of the greatest of all values in the [iterable] according
/// to the specified [comparator].
///
/// If the given [iterable] contains no comparable values (i.e., the comparator
/// returns [double.nan] when comparing each value to itself), returns -1.
///
/// If [comparator] is not specified, it defaults to [ascending]. For example:
///
/// ```dart
/// const array = [
///   {"foo": 42},
///   {"foo": 91}
/// ];
/// greatestIndex(array, (a, b) => a["foo"]! - b["foo"]!); // 1
/// greatestIndex(array, (a, b) => b["foo"]! - a["foo"]!); // 0
/// ```
///
/// This function is similar to [maxIndex], except that it accepts an iterable
/// of values ​​that do not implement the [Comparable] interface.
///
/// {@category Summarizing data}
int greatestIndex<T>(Iterable<T> iterable,
    [num Function(T, T) comparator = ascending]) {
  T? maxValue;
  var max = -1, index = -1;
  for (final value in iterable) {
    ++index;
    if (max < 0
        ? comparator(value, value) == 0
        : comparator(value, maxValue as T) > 0) {
      maxValue = value;
      max = index;
    }
  }
  return max;
}

/// Returns the index of the element with the greatest of all values yielded by
/// the [accessor] function applied to each element in the [iterable] according
/// to the specified [comparator].
///
/// If the given [iterable] contains no elements that yield comparable values
/// (i.e., the comparator returns [double.nan] when comparing each value to
/// itself), returns -1.
///
/// If [comparator] is not specified, it defaults to [ascending]. For example:
///
/// ```dart
/// const array = [
///   {"foo": 42},
///   {"foo": 91}
/// ];
/// greatestIndexBy(array, (a) => a["foo"]!); // 1
/// ```
///
/// This function is similar to [maxIndexBy], except that it accepts an iterable
/// of elements that yield values ​​that do not implement the [Comparable]
/// interface and returns the value yielded by the [accessor] function.
///
/// {@category Summarizing data}
int greatestIndexBy<T, R>(Iterable<T> iterable, R Function(T) accessor,
    [num Function(R, R) comparator = ascending]) {
  R? maxValue;
  var max = -1, index = -1;
  for (final element in iterable) {
    ++index;
    final value = accessor(element);
    if (max < 0
        ? comparator(value, value) == 0
        : comparator(value, maxValue as R) > 0) {
      maxValue = value;
      max = index;
    }
  }
  return max;
}
