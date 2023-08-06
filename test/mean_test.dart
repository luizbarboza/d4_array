import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("mean(array) returns the mean value for numbers", () {
    expect(mean([1]), 1);
    expect(mean([5, 1, 2, 3, 4]), 3);
    expect(mean([20, 3]), 11.5);
    expect(mean([3, 20]), 11.5);
  });

  test("mean(array) ignores null and NaN", () {
    expect(mean([double.nan, 1, 2, 3, 4, 5]), 3);
    expect(mean([1, 2, 3, 4, 5, double.nan]), 3);
    expect(mean([10, null, 3, null, 5, double.nan]), 6);
  });

  test("mean(array) returns null if the array contains no observed values", () {
    expect(mean([]), null);
    expect(mean([null]), null);
    expect(mean([double.nan]), null);
    expect(mean([double.nan, double.nan]), null);
  });

  test("mean(array, f) returns the mean value for numbers", () {
    expect(meanBy<Map<String, int>>([1].map(box), unbox), 1);
    expect(meanBy<Map<String, int>>([5, 1, 2, 3, 4].map(box), unbox), 3);
    expect(meanBy<Map<String, int>>([20, 3].map(box), unbox), 11.5);
    expect(meanBy<Map<String, int>>([3, 20].map(box), unbox), 11.5);
  });

  test("mean(array, f) ignores null, undefined and NaN", () {
    expect(
        meanBy<Map<String, num>>([double.nan, 1, 2, 3, 4, 5].map(box), unbox),
        3);
    expect(
        meanBy<Map<String, num>>([1, 2, 3, 4, 5, double.nan].map(box), unbox),
        3);
    expect(
        meanBy<Map<String, num?>>(
            [10, null, 3, null, 5, double.nan].map(box), unbox),
        6);
  });

  test(
      "mean(array, f) returns undefined if the array contains no observed values",
      () {
    expect(meanBy<Map<String, Never>>(<Never>[].map(box), unbox), null);
    expect(meanBy<Map<String, num?>>([null].map(box), unbox), null);
    expect(meanBy<Map<String, double>>([double.nan].map(box), unbox), null);
    expect(
        meanBy<Map<String, double>>([double.nan, double.nan].map(box), unbox),
        null);
  });
}

Map<String, T> box<T>(T value) {
  return {"value": value};
}

T unbox<T>(Map<String, T> box) {
  return box["value"] as dynamic;
}
