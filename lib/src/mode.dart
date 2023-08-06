/// Returns the mode of all values in the [iterable], i.e., the value which
/// appears the most often.
///
/// The mode is determined based on the frequency of occurrences using the
/// [Object.==] to compare values. In case of equality, returns the first of
/// the relevant values.
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
T? mode<T>(Iterable<T> iterable) {
  Map<T, int> counts = {};
  for (final value in iterable) {
    if (value != null && value == value) {
      counts[value] = (counts[value] ?? 0) + 1;
    }
  }
  T? modeValue;
  var modeCount = 0;
  for (final MapEntry(key: value, value: count) in counts.entries) {
    if (count > modeCount) {
      modeCount = count;
      modeValue = value;
    }
  }
  return modeValue;
}

/// Returns the mode of all values yielded by the [accessor] function applied to
/// each element in the [iterable], i.e., the value which appears the most
/// often.
///
/// The mode is determined based on the frequency of occurrences using the
/// [Object.==] to compare values. In case of equality, returns the first of
/// the relevant values.
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
R? modeBy<T, R>(Iterable<T> iterable, R Function(T) accessor) {
  Map<R, int> counts = {};
  for (final element in iterable) {
    final value = accessor(element);
    if (value != null && value == value) {
      counts[value] = (counts[value] ?? 0) + 1;
    }
  }
  R? modeKey;
  var modeCount = 0;
  for (var MapEntry(key: value, value: count) in counts.entries) {
    if (count > modeCount) {
      modeCount = count;
      modeKey = value;
    }
  }
  return modeKey;
}
