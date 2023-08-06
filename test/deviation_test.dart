import 'dart:math';

import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test(
      "deviation(array) returns the standard deviation of the specified numbers",
      () {
    expect(deviation([1, 1, 1, 1, 1]), 0);
    expect(deviation([5, 1, 2, 3, 4]), sqrt(2.5));
    expect(deviation([20, 3]), sqrt(144.5));
    expect(deviation([3, 20]), sqrt(144.5));
  });

  test("deviation(array) ignores null and NaN", () {
    expect(deviation([double.nan, 1, 2, 3, 4, 5]), sqrt(2.5));
    expect(deviation([1, 2, 3, 4, 5, double.nan]), sqrt(2.5));
    expect(deviation([10, null, 3, null, 5, double.nan]), sqrt(13));
  });

  test("deviation(array) can handle large numbers without overflowing", () {
    expect(deviation([double.maxFinite, double.maxFinite]), 0);
    expect(deviation([-double.maxFinite, -double.maxFinite]), 0);
  });

  test("deviation(array) returns null if the array has fewer than two numbers",
      () {
    expect(deviation([1]), null);
    expect(deviation([]), null);
    expect(deviation([null]), null);
    expect(deviation([double.nan]), null);
    expect(deviation([double.nan, double.nan]), null);
  });

  test("deviationBy(array, f) returns the deviation of the specified numbers",
      () {
    expect(deviationBy([5, 1, 2, 3, 4].map(box), unbox), sqrt(2.5));
    expect(deviationBy([20, 3].map(box), unbox), sqrt(144.5));
    expect(deviationBy([3, 20].map(box), unbox), sqrt(144.5));
  });

  test("deviationBy(array, f) ignores null and NaN", () {
    expect(
        deviationBy<Map<String, num>>(
            [double.nan, 1, 2, 3, 4, 5].map(box), unbox),
        sqrt(2.5));
    expect(
        deviationBy<Map<String, num>>(
            [1, 2, 3, 4, 5, double.nan].map(box), unbox),
        sqrt(2.5));
    expect(
        deviationBy<Map<String, num?>>(
            [10, null, 3, null, 5, double.nan].map(box), unbox),
        sqrt(13));
  });

  test("deviationBy(array, f) can handle large numbers without overflowing",
      () {
    expect(
        deviationBy<Map<String, double>>(
            [double.maxFinite, double.maxFinite].map(box), unbox),
        0);
    expect(
        deviationBy<Map<String, double>>(
            [-double.maxFinite, -double.maxFinite].map(box), unbox),
        0);
  });

  test(
      "deviationBy(array, f) returns null if the array has fewer than two numbers",
      () {
    expect(deviationBy<Map<String, int>>([1].map(box), unbox), null);
    expect(deviationBy<Map<String, Never>>(<Never>[].map(box), unbox), null);
    expect(deviationBy<Map<String, num?>>([null].map(box), unbox), null);
    expect(
        deviationBy<Map<String, double>>([double.nan].map(box), unbox), null);
    expect(
        deviationBy<Map<String, double>>(
            [double.nan, double.nan].map(box), unbox),
        null);
  });
}

Map<String, T> box<T>(T value) {
  return {"value": value};
}

T unbox<T>(Map<String, T> box) {
  return box["value"] as dynamic;
}
