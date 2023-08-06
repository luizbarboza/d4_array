import 'dart:typed_data';

import 'greatest.dart';
import 'max.dart';
import 'max_index.dart';
import 'min.dart';
import 'min_index.dart';
import 'number.dart';
import 'quickselect.dart';
import 'sort.dart';

/// Returns the [p]-quantile of all values in the [iterable], where [p] is a
/// number in the range \[0, 1\].
///
/// For example, the median can be computed using [p] = 0.5, the first quartile
/// at [p] = 0.25, and the third quartile at [p] = 0.75.
///
/// This particular implementation uses the
/// [R-7 method](http://en.wikipedia.org/wiki/Quantile#Quantiles_of_a_population),
/// which is the default for the R programming language and Excel.
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
num? quantile(Iterable<num?> iterable, num p) {
  var elements = numbers(iterable), n = elements.length;
  if (n == 0 || p.isNaN) return null;
  if (p <= 0 || n < 2) return min(elements);
  if (p >= 1) return max(elements);
  var i = (n - 1) * p,
      i0 = i.floor(),
      value0 = max(quickselect(elements, i0).sublist(0, i0 + 1))!,
      value1 = min(elements.sublist(i0 + 1))!;
  return value0 + (value1 - value0) * (i - i0);
}

/// Returns the [p]-quantile of all values yielded by the [accessor] function
/// applied to each element in the [iterable], where [p] is a number in the
/// range \[0, 1\].
///
/// For example, the median can be computed using [p] = 0.5, the first quartile
/// at [p] = 0.25, and the third quartile at [p] = 0.75.
///
/// This particular implementation uses the
/// [R-7 method](http://en.wikipedia.org/wiki/Quantile#Quantiles_of_a_population),
/// which is the default for the R programming language and Excel.
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
num? quantileBy<T>(Iterable<T> iterable, num p, num? Function(T) accessor) {
  var elements = numbersBy(iterable, accessor), n = elements.length;
  if (n == 0 || p.isNaN) return null;
  if (p <= 0 || n < 2) return min(elements);
  if (p >= 1) return max(elements);
  var i = (n - 1) * p,
      i0 = i.floor(),
      value0 = max(quickselect(elements, i0).sublist(0, i0 + 1))!,
      value1 = min(elements.sublist(i0 + 1))!;
  return value0 + (value1 - value0) * (i - i0);
}

/// Similar to [quantile], but expects the input to be **sorted**.
///
/// {@category Summarizing data}
num? quantileSorted(Iterable<num?> values, num p) {
  var n = values.length;
  if (n == 0 || p.isNaN) return null;
  if (p <= 0 || n < 2) return values.elementAt(0);
  if (p >= 1) return values.elementAt(n - 1);
  var i = (n - 1) * p,
      i0 = i.floor(),
      value0 = nanIfNull(values.elementAt(i0)),
      value1 = nanIfNull(values.elementAt(i0 + 1));
  return value0 + (value1 - value0) * (i - i0);
}

/// Similar to [quantileBy], but expects the input to be **sorted**. In contrast
/// with [quantileBy], the [accessor] is only called on the elements needed to
/// compute the quantile.
///
/// {@category Summarizing data}
num? quantileSortedBy<T>(Iterable<T> values, num p, num? Function(T) accessor) {
  var n = values.length;
  if (n == 0 || p.isNaN) return null;
  if (p <= 0 || n < 2) return accessor(values.elementAt(0));
  if (p >= 1) return accessor(values.elementAt(n - 1));
  var i = (n - 1) * p,
      i0 = i.floor(),
      value0 = zeroIfNull(accessor(values.elementAt(i0))),
      value1 = zeroIfNull(accessor(values.elementAt(i0 + 1)));
  return value0 + (value1 - value0) * (i - i0);
}

/// Similar to [quantile], but returns the index to the left of [p].
///
/// {@category Summarizing data}
int? quantileIndex(Iterable<num?> iterable, num p) {
  if (p.isNaN) return null;
  var k = iterable.length, numbers = iterable.map(nanIfNull).toList();
  if (p <= 0) return minIndex(numbers);
  if (p >= 1) return maxIndex(numbers);
  var index = Uint32List(k), j = k - 1, i = (j * p).floor();
  for (var i = 0; i < k; i++) {
    index[i] = i;
  }
  quickselect<Uint32List, int>(index, i,
      left: 0,
      right: j,
      compare: (i, j) => ascendingDefined(numbers[i], numbers[j]));
  var i0 =
      greatestBy(Uint32List.sublistView(index, 0, i + 1), (i) => numbers[i]);
  return i0 != null && i0 >= 0 ? i0 : -1;
}

/// Similar to [quantileBy], but returns the index to the left of [p].
///
/// {@category Summarizing data}
int? quantileIndexBy<T>(Iterable<T> values, num p, num? Function(T) accessor) {
  if (p.isNaN) return null;
  var k = values.length,
      numbers =
          List.generate(k, (i) => nanIfNull(accessor(values.elementAt(i))));
  if (p <= 0) return minIndex(numbers);
  if (p >= 1) return maxIndex(numbers);
  var index = Uint32List(k), j = k - 1, i = (j * p).floor();
  for (var i = 0; i < k; i++) {
    index[i] = i;
  }
  quickselect<Uint32List, int>(index, i,
      left: 0,
      right: j,
      compare: (i, j) => ascendingDefined(numbers[i], numbers[j]));
  var i0 =
      greatestBy(Uint32List.sublistView(index, 0, i + 1), (i) => numbers[i]);
  return i0 != null && i0 >= 0 ? i0 : -1;
}
