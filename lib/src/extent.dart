/// Returns the minimum and maximum values in the [iterable].
///
/// The minimum and maximum values are determined based on the natural ordering
/// of the values, as defined by the [Comparable] interface.
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
/// returns `(null, null)`.
///
/// {@category Summarizing data}
(T?, T?) extent<T extends Comparable?>(Iterable<T> iterable) {
  T? min, max;
  for (final value in iterable) {
    if (value == null || value != value) continue;
    if (min == null || max == null) {
      min = max = value;
      continue;
    }
    if (min.compareTo(value) > 0) min = value;
    if (max.compareTo(value) < 0) max = value;
  }
  return (min, max);
}

/// Returns the minimum and maximum values yielded by the [accessor] function
/// applied to each element in the [iterable].
///
/// The minimum and maximum values are determined based on the natural ordering
/// of the values, as defined by the [Comparable] interface.
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
/// this function returns `(null, null)`.
///
/// {@category Summarizing data}
(R?, R?) extentBy<T, R extends Comparable?>(
    Iterable<T> iterable, R Function(T) accessor) {
  R? min, max;
  for (final element in iterable) {
    final value = accessor(element);
    if (value == null || value != value) continue;
    if (min == null || max == null) {
      min = max = value;
      continue;
    }
    if (min.compareTo(value) > 0) min = value;
    if (max.compareTo(value) < 0) max = value;
  }
  return (min, max);
}
