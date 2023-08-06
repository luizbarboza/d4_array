/// Returns the index of the maximum of all values in the [iterable].
///
/// The maximum is determined based on the natural ordering of the values, as
/// defined by the [Comparable] interface.
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
/// returns -1.
///
/// {@category Summarizing data}
int maxIndex<T extends Comparable?>(Iterable<T> iterable) {
  T? max;
  var maxIndex = -1, index = -1;
  for (final value in iterable) {
    ++index;
    if (value == null || value != value) continue;
    if (max == null || max.compareTo(value) < 0) {
      max = value;
      maxIndex = index;
    }
  }
  return maxIndex;
}

/// Returns the index of the maximum of all values yielded by the [accessor]
/// function applied to each element in the [iterable].
///
/// The maximum is determined based on the natural ordering of the values, as
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
/// this function returns -1.
///
/// {@category Summarizing data}
int maxIndexBy<T, R extends Comparable?>(
    Iterable<T> iterable, R Function(T) accessor) {
  R? max;
  var maxIndex = -1, index = -1;
  for (final element in iterable) {
    ++index;
    final value = accessor(element);
    if (value == null || value != value) continue;
    if (max == null || max.compareTo(value) < 0) {
      max = value;
      maxIndex = index;
    }
  }
  return maxIndex;
}
