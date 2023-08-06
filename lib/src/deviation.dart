import 'dart:math';

import 'variance.dart';

/// Returns the standard deviation, defined as the square root of the
/// bias-corrected [variance], of all values in the [iterable].
///
/// This function ignores values that do not satisfy any of the following
/// conditions:
///   1. The value is not `null`.
///   2. The value is not [double.nan].
///
/// Useful for filtering and ignoring missing data in datasets.
///
/// If the [iterable] has fewer than two valid values, this function returns
/// `null`.
///
/// {@category Summarizing data}
num? deviation(Iterable<num?> iterable) {
  var v = variance(iterable);
  return v != null ? sqrt(v) : v;
}

/// Returns the standard deviation, defined as the square root of the
/// bias-corrected [variance], of all values yielded by the [accessor] function
/// applied to each element in the [iterable].
///
/// This function ignores elements that yield values that do not satisfy any of
/// the following conditions:
///   1. The value is not `null`.
///   2. The value is not [double.nan].
///
/// Useful for filtering and ignoring missing data in datasets.
///
/// If the [iterable] has fewer than two elements that yield valid values, this
/// function returns `null`.
///
/// {@category Summarizing data}
num? deviationBy<T>(Iterable<T> iterable, num? Function(T) accessor) {
  var v = varianceBy<T>(iterable, accessor);
  return v != null ? sqrt(v) : v;
}
