/// Returns the cumsum of all values in the [iterable].
///
/// This function ignores values that do not satisfy any of the following
/// conditions:
///   1. The value is not `null`.
///   2. The value is not [double.nan].
///
/// Useful for filtering and ignoring missing data in datasets.
///
/// {@category Summarizing data}
List<num?> cumsum(Iterable<num?> iterable) {
  num sum = 0;
  return List.generate(iterable.length, (i) {
    var v = iterable.elementAt(i);
    return v != null && !v.isNaN ? sum += v : sum;
  });
}

/// Returns the cumsum of all values yielded by the [accessor] function applied
/// to each element in the [iterable], as a list of the same length.
///
/// This function ignores values that do not satisfy any of the following
/// conditions:
///   1. The value is not `null`.
///   2. The value is not [double.nan].
///
/// Useful for filtering and ignoring missing data in datasets.
///
/// {@category Summarizing data}
List<num> cumsumBy<T>(Iterable<T> iterable, num? Function(T) accessor) {
  num sum = 0;
  return List.generate(iterable.length, (i) {
    var v = accessor(iterable.elementAt(i));
    return v != null && !v.isNaN ? sum += v : sum;
  });
}
