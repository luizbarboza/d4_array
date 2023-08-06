/// Returns an [unbiased estimator of the population variance](http://mathworld.wolfram.com/SampleVariance.html)
/// of all values in the [iterable] using
/// [Welford’s algorithm](https://en.wikipedia.org/wiki/Algorithms_for_calculating_variance#Welford's_online_algorithm).
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
num? variance(Iterable<num?> iterable) {
  var count = 0;
  num delta, mean = 0, sum = 0;
  for (var value in iterable) {
    if (value != null && value == value) {
      delta = value - mean;
      mean += delta / ++count;
      sum += delta * (value - mean);
    }
  }
  return count > 1 ? sum / (count - 1) : null;
}

/// Returns an [unbiased estimator of the population variance](http://mathworld.wolfram.com/SampleVariance.html)
/// of all values yielded by the [accessor] function applied to each element in
/// the [iterable] using
/// [Welford’s algorithm](https://en.wikipedia.org/wiki/Algorithms_for_calculating_variance#Welford's_online_algorithm).
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
num? varianceBy<T>(Iterable<T> iterable, num? Function(T) accessor) {
  var count = 0;
  num delta, mean = 0, sum = 0;
  for (var element in iterable) {
    var value = accessor(element);
    if (value != null && value == value) {
      delta = value - mean;
      mean += delta / ++count;
      sum += delta * (value - mean);
    }
  }
  return count > 1 ? sum / (count - 1) : null;
}
