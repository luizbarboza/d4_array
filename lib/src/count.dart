/// Returns the count of values in the [iterable].
///
/// This function ignores values that do not satisfy any of the following
/// conditions:
///   1. The value is not `null`.
///   2. The value is not [double.nan].
///
/// For example:
///
/// ```dart
/// count([double.nan, 18, null]); // 1
/// ```
///
/// If the [iterable] is empty or contains no valid values, this function
/// returns 0.
///
/// {@category Summarizing data}
int count(Iterable<num?> iterable) {
  var count = 0;
  for (final value in iterable) {
    if (value != null && value == value) count++;
  }
  return count;
}

void main() {
  var count = countBy([
    {'n': "Alice", "age": double.nan},
    {"n": "Bob", "age": 18},
    {"n": "Other", "age": null}
  ], (d) => d["age"] as num?); // 1
  print(count);
}

/// Returns the count of values yielded by the [accessor] function applied to
/// each element in the [iterable].
///
/// This function ignores elements that yield values that do not satisfy any of
/// the following conditions:
///   1. The value is not `null`.
///   2. The value is not [double.nan].
///
/// For example:
///
/// ```dart
/// countBy([{'n': "Alice", "age": double.nan}, {"n": "Bob", "age": 18}, {"n": "Other", "age": null}], (d) => d["age"] as num?); // 1
/// ```
///
/// If the [iterable] is empty or contains no elements that yield valid values,
/// this function returns 0.
///
/// {@category Summarizing data}
int? countBy<T>(Iterable<T> iterable, num? Function(T) accessor) {
  var count = 0;
  for (final element in iterable) {
    final value = accessor(element);
    if (value != null && value == value) count++;
  }
  return count;
}
