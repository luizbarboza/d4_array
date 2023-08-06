import 'dart:math' as math;

import '../count.dart';

/// Returns the number of bins according to
/// [Sturges’ formula](https://en.wikipedia.org/wiki/Histogram#Mathematical_definition);
/// the input [values] must be numbers.
///
/// {@category Binning data}
int thresholdSturges(Iterable<num?> values, [num? min, num? max]) {
  return math.max(1, (math.log(count(values)) / math.ln2).ceil() + 1);
}
