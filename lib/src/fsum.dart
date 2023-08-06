import 'dart:typed_data';

import 'cumsum.dart';
import 'sum.dart';

/// Creates a full precision adder for [IEEE 754](https://en.wikipedia.org/wiki/IEEE_754)
/// floating point numbers, setting its initial value to 0.
///
/// {@category Adding numbers}
class Adder {
  final Float64List _partials = Float64List(32);
  int _n = 0;

  /// Adds the specified number to the adder’s current value.
  void add(double x) {
    final p = _partials;
    var i = 0;
    for (var j = 0; j < _n && j < 32; j++) {
      final y = p[j],
          hi = x + y,
          lo = x.abs() < y.abs() ? x - (hi - y) : y - (hi - x);
      if (lo != 0) p[i++] = lo;
      x = hi;
    }
    p[i] = x;
    _n = i + 1;
  }

  /// Returns the IEEE 754 double precision representation of the adder’s
  /// current value.
  double valueOf() {
    final p = _partials;
    var n = _n;
    late double x, y, lo, hi = 0;
    if (n > 0) {
      hi = p[--n];
      while (n > 0) {
        x = hi;
        y = p[--n];
        hi = x + y;
        lo = y - (hi - x);
        if (lo != 0) break;
      }
      if (n > 0 && ((lo < 0 && p[n - 1] < 0) || (lo > 0 && p[n - 1] > 0))) {
        y = lo * 2;
        x = hi + y;
        if (y == x - hi) hi = x;
      }
    }
    return hi;
  }
}

/// Returns a full precision summation of all values in the [iterable].
///
/// ```dart
/// fsum([.1, .1, .1, .1, .1, .1, .1, .1, .1, .1]); // 1
/// sum([.1, .1, .1, .1, .1, .1, .1, .1, .1, .1]); // 0.9999999999999999
/// ```
///
/// Although slower, [fsum] can replace [sum] wherever greater precision is
/// needed. Uses [Adder].
///
/// This function ignores values that do not satisfy any of the following
/// conditions:
///   1. The value is not `null`.
///   2. The value is not [double.nan].
///
/// Useful for filtering and ignoring missing data in datasets.
///
/// If the [iterable] is empty or contains no valid values, this function
/// returns 0.
///
/// {@category Adding numbers}
double fsum(Iterable<num?> iterable) {
  final adder = Adder();
  for (var value in iterable) {
    if (value != null && value == value) {
      adder.add(value.toDouble());
    }
  }
  return adder.valueOf();
}

/// Returns a full precision summation of all values yielded by the [accessor]
/// function applied to each element in the [iterable].
///
/// ```dart
/// fsumBy([.1, .1, .1, .1, .1, .1, .1, .1, .1, .1], (d) => d * 2); // 2
/// sumBy([.1, .1, .1, .1, .1, .1, .1, .1, .1, .1], (d) => d * 2); // 1.9999999999999998
/// ```
///
/// Although slower, [fsum] can replace [sum] wherever greater precision is
/// needed. Uses [Adder].
///
/// This function ignores elements that yield values that do not satisfy any of
/// the following conditions:
///   1. The value is not `null`.
///   2. The value is not [double.nan].
///
/// Useful for filtering and ignoring missing data in datasets.
///
/// If the [iterable] is empty or contains no elements that yield valid values,
/// this function returns 0.
///
/// {@category Adding numbers}
double fsumBy<T>(Iterable<T> iterable, num? Function(T) accessor) {
  final adder = Adder();
  for (var value in iterable) {
    var result = accessor(value);
    if (result != null && result == result) {
      adder.add(result.toDouble());
    }
  }
  return adder.valueOf();
}

/// Returns a full precision cumulative sum of all values in the [iterable].
///
/// ```dart
/// fcumsum([1, 1e-14, -1]); // [1, 1.00000000000001, 1e-14]
/// cumsum([1, 1e-14, -1]); // [1, 1.00000000000001, 9.992e-15]
/// ```
///
/// Although slower, [fcumsum] can replace [cumsum] wherever greater precision
/// is needed. Uses [Adder].
///
/// This function ignores values that do not satisfy any of the following
/// conditions:
///   1. The value is not `null`.
///   2. The value is not [double.nan].
///
/// Useful for filtering and ignoring missing data in datasets.
///
/// {@category Adding numbers}
Float64List fcumsum(Iterable<num?> iterable) {
  final adder = Adder(), l = iterable.length, fcumsum = Float64List(l);
  for (var i = 0; i < l; i++) {
    var v = iterable.elementAt(i);
    fcumsum[i] =
        (adder..add(v != null && !v.isNaN ? v.toDouble() : 0)).valueOf();
  }
  return fcumsum;
}

/// Returns a full precision cumulative sum of all values yielded by the
/// [accessor] function applied to each element in the [iterable].
///
/// ```dart
/// fcumsumBy([.1, .1, .1, .1, .1, .1, .1, .1, .1, .1], (d) => d * 2); // [2.0, 2.00000000000002, 2e-14]
/// cumsumBy([.1, .1, .1, .1, .1, .1, .1, .1, .1, .1], (d) => d * 2); // [2, 2.00000000000002, 1.998e-14]
/// ```
///
/// Although slower, [fcumsumBy] can replace [cumsumBy] wherever greater
/// precision is needed. Uses [Adder].
///
/// This function ignores elements that yield values that do not satisfy any of
/// the following conditions:
///   1. The value is not `null`.
///   2. The value is not [double.nan].
///
/// Useful for filtering and ignoring missing data in datasets.
///
/// {@category Adding numbers}
Float64List fcumsumBy<T>(Iterable<T> iterable, num? Function(T) accessor) {
  final adder = Adder(), l = iterable.length, fcumsum = Float64List(l);
  for (var i = 0; i < l; i++) {
    var v = accessor(iterable.elementAt(i));
    fcumsum[i] =
        (adder..add(v != null && !v.isNaN ? v.toDouble() : 0)).valueOf();
  }
  return fcumsum;
}
