import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("variance(array) returns the variance of the specified numbers", () {
    expect(variance([5, 1, 2, 3, 4]), 2.5);
    expect(variance([20, 3]), 144.5);
    expect(variance([3, 20]), 144.5);
  });

  test("variance(array) ignores null and NaN", () {
    expect(variance([double.nan, 1, 2, 3, 4, 5]), 2.5);
    expect(variance([1, 2, 3, 4, 5, double.nan]), 2.5);
    expect(variance([10, null, 3, null, 5, double.nan]), 13);
  });

  test("variance(array) can handle large numbers without overflowing", () {
    expect(variance([double.maxFinite, double.maxFinite]), 0);
    expect(variance([-double.maxFinite, -double.maxFinite]), 0);
  });

  test("variance(array) returns null if the array has fewer than two numbers",
      () {
    expect(variance([1]), null);
    expect(variance([]), null);
    expect(variance([null]), null);
    expect(variance([double.nan]), null);
    expect(variance([double.nan, double.nan]), null);
  });

  test("varianceBy(array, f) returns the variance of the specified numbers",
      () {
    expect(varianceBy<Map<String, int>>([5, 1, 2, 3, 4].map(box), unbox), 2.5);
    expect(varianceBy<Map<String, int>>([20, 3].map(box), unbox), 144.5);
    expect(varianceBy<Map<String, int>>([3, 20].map(box), unbox), 144.5);
  });

  test("varianceBy(array, f) ignores null and NaN", () {
    expect(
        varianceBy<Map<String, num>>(
            [double.nan, 1, 2, 3, 4, 5].map(box), unbox),
        2.5);
    expect(
        varianceBy<Map<String, num>>(
            [1, 2, 3, 4, 5, double.nan].map(box), unbox),
        2.5);
    expect(
        varianceBy<Map<String, num?>>(
            [10, null, 3, null, 5, double.nan].map(box), unbox),
        13);
  });

  test("varianceBy(array, f) can handle large numbers without overflowing", () {
    expect(
        varianceBy<Map<String, double>>(
            [double.maxFinite, double.maxFinite].map(box), unbox),
        0);
    expect(
        varianceBy<Map<String, double>>(
            [-double.maxFinite, -double.maxFinite].map(box), unbox),
        0);
  });

  test(
      "varianceBy(array, f) returns null if the array has fewer than two numbers",
      () {
    expect(varianceBy<Map<String, int>>([1].map(box), unbox), null);
    expect(varianceBy<Map<String, Never>>(<Never>[].map(box), unbox), null);
    expect(varianceBy<Map<String, num?>>([null].map(box), unbox), null);
    expect(varianceBy<Map<String, double>>([double.nan].map(box), unbox), null);
    expect(
        varianceBy<Map<String, double>>(
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
