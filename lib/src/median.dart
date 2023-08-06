import 'quantile.dart';

/// Returns the median of all values in the [iterable] using the
/// [R-7 method](https://en.wikipedia.org/wiki/Quantile#Estimating_quantiles_from_a_sample).
///
/// This function ignores values that do not satisfy any of the following
/// conditions:
///   1. The value is not `null`.
///   2. The value is not [double.nan].
///
/// Useful for filtering and ignoring missing data in datasets.
///
/// If the [iterable] is empty or contains no valid values, this function
/// returns `null`.
///
/// {@category Summarizing data}
num? median(Iterable<num?> iterable) {
  return quantile(iterable, 0.5);
}

/// Returns the median of all values yielded by the [accessor] function applied
/// to each element in the [iterable] using the
/// [R-7 method](https://en.wikipedia.org/wiki/Quantile#Estimating_quantiles_from_a_sample).
///
/// This function ignores elements that yield values that do not satisfy any of
/// the following conditions:
///   1. The value is not `null`.
///   2. The value is not [double.nan].
///
/// Useful for filtering and ignoring missing data in datasets.
///
/// If the [iterable] is empty or contains no elements that yield valid values,
/// this function returns `null`.
///
/// {@category Summarizing data}
num? medianBy<T>(Iterable<T> iterable, num? Function(T) accessor) {
  return quantileBy(iterable, 0.5, accessor);
}

/// Similar to [median], but returns the index of the value to the left of the
/// median.
///
/// {@category Summarizing data}
int? medianIndex(Iterable<num?> values) {
  return quantileIndex(values, 0.5);
}

/// Similar to [medianBy], but returns the index of the element that yields the
/// value to the left of the median.
///
/// {@category Summarizing data}
int? medianIndexBy<T>(Iterable<T> values, num? Function(T) accessor) {
  return quantileIndexBy(values, 0.5, accessor);
}
