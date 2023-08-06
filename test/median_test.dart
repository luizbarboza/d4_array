import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("median(array) returns the median value for numbers", () {
    expect(median([1]), 1);
    expect(median([5, 1, 2, 3]), 2.5);
    expect(median([5, 1, 2, 3, 4]), 3);
    expect(median([20, 3]), 11.5);
    expect(median([3, 20]), 11.5);
  });

  test("median(array) ignores null and NaN", () {
    expect(median([double.nan, 1, 2, 3, 4, 5]), 3);
    expect(median([1, 2, 3, 4, 5, double.nan]), 3);
    expect(median([10, null, 3, null, 5, double.nan]), 5);
  });

  test("median(array) can handle large numbers without overflowing", () {
    expect(median([double.maxFinite, double.maxFinite]), double.maxFinite);
    expect(median([-double.maxFinite, -double.maxFinite]), -double.maxFinite);
  });

  test("median(array) returns null if the array contains no observed values",
      () {
    expect(median([]), null);
    expect(median([null]), null);
    expect(median([double.nan]), null);
    expect(median([double.nan, double.nan]), null);
  });

  test("medianBy(array, f) returns the median value for numbers", () {
    expect(medianBy<Map<String, int>>([1].map(box), unbox), 1);
    expect(medianBy<Map<String, int>>([5, 1, 2, 3, 4].map(box), unbox), 3);
    expect(medianBy<Map<String, int>>([20, 3].map(box), unbox), 11.5);
    expect(medianBy<Map<String, int>>([3, 20].map(box), unbox), 11.5);
  });

  test("medianBy(array, f) ignores null and NaN", () {
    expect(
        medianBy<Map<String, num>>([double.nan, 1, 2, 3, 4, 5].map(box), unbox),
        3);
    expect(
        medianBy<Map<String, num>>([1, 2, 3, 4, 5, double.nan].map(box), unbox),
        3);
    expect(
        medianBy<Map<String, num?>>(
            [10, null, 3, null, 5, double.nan].map(box), unbox),
        5);
  });

  test("medianBy(array, f) can handle large numbers without overflowing", () {
    expect(
        medianBy<Map<String, double>>(
            [double.maxFinite, double.maxFinite].map(box), unbox),
        double.maxFinite);
    expect(
        medianBy<Map<String, double>>(
            [-double.maxFinite, -double.maxFinite].map(box), unbox),
        -double.maxFinite);
  });

  test(
      "medianBy(array, f) returns null if the array contains no observed values",
      () {
    expect(medianBy<Map<String, Never>>(<Never>[].map(box), unbox), null);
    expect(medianBy<Map<String, num?>>([null].map(box), unbox), null);
    expect(medianBy<Map<String, double>>([double.nan].map(box), unbox), null);
    expect(
        medianBy<Map<String, double>>([double.nan, double.nan].map(box), unbox),
        null);
  });

  test("medianIndex(array) returns the index", () {
    expect(medianIndex([1, 2]), 0);
    expect(medianIndex([1, 2, 3]), 1);
    expect(medianIndex([1, 3, 2]), 2);
    expect(medianIndex([2, 3, 1]), 0);
    expect(medianIndex([1]), 0);
    expect(medianIndex([]), -1);
  });
}

Map<String, T> box<T>(T value) {
  return {"value": value};
}

T unbox<T>(Map<String, T> box) {
  return box["value"] as dynamic;
}
