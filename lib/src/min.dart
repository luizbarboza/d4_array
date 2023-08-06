/// Returns the minimum of all values in the [iterable].
///
/// The minimum is determined based on the natural ordering of the values,
/// as defined by the [Comparable] interface.
///
/// This function ignores values that do not satisfy any of the following
/// conditions:
///   1. The value is not `null`.
///   2. The value is not a special case like [double.nan], which does not
/// satisfy self-equality according to [Object.==].
///
/// Useful for filtering and ignoring missing data in datasets.
///
/// If the [iterable] is empty or contains no valid values, this function
/// returns `null`.
///
/// {@category Summarizing data}
T? min<T extends Comparable?>(Iterable<T> iterable) {
  T? min;
  for (final element in iterable) {
    if (element == null || element != element) continue;
    if (min == null || min.compareTo(element) > 0) min = element;
  }
  return min;
}

/// Returns the minimum of all values yielded by the [accessor] function applied
/// to each element in the [iterable].
///
/// The minimum is determined based on the natural ordering of the values, as
/// defined by the [Comparable] interface.
///
/// This function ignores elements that yield values that do not satisfy any of
/// the following conditions:
///   1. The value is not `null`.
///   2. The value is not a special case like [double.nan], which does not
/// satisfy self-equality according to [Object.==].
///
/// Useful for filtering and ignoring missing data in datasets.
///
/// If the [iterable] is empty or contains no elements that yield valid values,
/// this function returns `null`.
///
/// {@category Summarizing data}
R? minBy<T, R extends Comparable?>(
    Iterable<T> iterable, R Function(T) accessor) {
  R? min;
  for (final element in iterable) {
    final value = accessor(element);
    if (value == null || value != value) continue;
    if (min == null || min.compareTo(value) > 0) min = value;
  }
  return min;
}
