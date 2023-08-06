import 'dart:math';

import '../count.dart';
import '../quantile.dart';

/// Returns the number of bins according to the
/// [Freedman–Diaconis rule](https://en.wikipedia.org/wiki/Histogram#Mathematical_definition);
/// the input [values] must be numbers.
///
/// {@category Binning data}
int thresholdFreedmanDiaconis<T>(Iterable<num?> values, num min, num max) {
  final c = count(values),
      d = (quantile(values, 0.75) ?? double.nan) -
          (quantile(values, 0.25) ?? double.nan);
  return c != 0 && d != 0 && d.isFinite
      ? ((max - min) / (2 * d * pow(c, -1 / 3))).ceil()
      : 1;
}
