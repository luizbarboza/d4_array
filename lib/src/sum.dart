/// Returns the sum of all values in the [iterable].
///
/// This function ignores values that do not satisfy any of the following
/// conditions:
///   1. The value is not `null`.
///   2. The value is not [double.nan].
///
/// Useful for filtering and ignoring missing data in datasets.
///
/// If the [iterable] is empty or contains no valid values, this function
/// returns 0.
///
/// {@category Summarizing data}
num sum(Iterable<num?> iterable) {
  num sum = 0;
  for (final value in iterable) {
    if (value != null && !value.isNaN) sum += value;
  }
  return sum;
}

/// Returns the sum of all values yielded by the [accessor] function applied to
/// each element in the [iterable].
///
/// This function ignores elements that yield values that do not satisfy any of
/// the following conditions:
///   1. The value is not `null`.
///   2. The value is not [double.nan].
///
/// Useful for filtering and ignoring missing data in datasets.
///
/// If the [iterable] is empty or contains no elements that yield valid values,
/// this function returns 0.
///
/// {@category Summarizing data}
num sumBy<T>(Iterable<T> iterable, num? Function(T) accessor) {
  num sum = 0;
  for (final element in iterable) {
    var value = accessor(element);
    if (value != null && !value.isNaN) sum += value;
  }
  return sum;
}
