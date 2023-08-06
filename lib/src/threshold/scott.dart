import 'dart:math';

import '../count.dart';
import '../deviation.dart';

/// Returns the number of bins according to
/// [Scott’s normal reference rule](https://en.wikipedia.org/wiki/Histogram#Mathematical_definition);
/// the input [values] must be numbers.
///
/// {@category Binning data}
int thresholdScott<T>(Iterable<num?> values, num min, num max) {
  final c = count(values), d = deviation(values) ?? 0;
  return c != 0 && d != 0
      ? ((max - min) * pow(c, 1 / 3) / (3.49 * d)).ceil()
      : 1;
}
