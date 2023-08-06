import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("min(array) returns the least numeric value for numbers", () {
    expect(min([1]), 1);
    expect(min([5, 1, 2, 3, 4]), 1);
    expect(min([20, 3]), 3);
    expect(min([3, 20]), 3);
  });

  test("min(array) returns the least lexicographic value for strings", () {
    expect(min(["c", "a", "b"]), "a");
    expect(min(["20", "3"]), "20");
    expect(min(["3", "20"]), "20");
  });

  test("min(array) ignores null and NaN", () {
    expect(min([double.nan, 1, 2, 3, 4, 5]), 1);
    expect(min([1, 2, 3, 4, 5, double.nan]), 1);
    expect(min([10, null, 3, null, 5, double.nan]), 3);
    expect(min([-1, null, -3, null, -5, double.nan]), -5);
  });

  test("min(array) returns null if the array contains no numbers", () {
    expect(min<Never>([]), null);
    expect(min([null]), null);
    expect(min([double.nan]), null);
    expect(min([double.nan, double.nan]), null);
  });

  test("minBy(array, f) returns the least numeric value for numbers", () {
    expect(minBy<Map<String, int>, int>([1].map(box), unbox), 1);
    expect(minBy<Map<String, int>, int>([5, 1, 2, 3, 4].map(box), unbox), 1);
    expect(minBy<Map<String, int>, int>([20, 3].map(box), unbox), 3);
    expect(minBy<Map<String, int>, int>([3, 20].map(box), unbox), 3);
  });

  test("minBy(array, f) returns the least lexicographic value for strings", () {
    expect(minBy<Map<String, String>, String>(["c", "a", "b"].map(box), unbox),
        "a");
    expect(
        minBy<Map<String, String>, String>(["20", "3"].map(box), unbox), "20");
    expect(
        minBy<Map<String, String>, String>(["3", "20"].map(box), unbox), "20");
  });

  test("minBy(array, f) ignores null and NaN", () {
    expect(
        minBy<Map<String, num>, num>(
            [double.nan, 1, 2, 3, 4, 5].map(box), unbox),
        1);
    expect(
        minBy<Map<String, num>, num>(
            [1, 2, 3, 4, 5, double.nan].map(box), unbox),
        1);
    expect(
        minBy<Map<String, num?>, num?>(
            [10, null, 3, null, 5, double.nan].map(box), unbox),
        3);
    expect(
        minBy<Map<String, num?>, num?>(
            [-1, null, -3, null, -5, double.nan].map(box), unbox),
        -5);
  });

  test("minBy(array, f) returns null if the array contains no observed values",
      () {
    expect(minBy<Map<String, Never>, Never>(<Never>[].map(box), unbox), null);
    expect(minBy<Map<String, num?>, num?>([null].map(box), unbox), null);
    expect(
        minBy<Map<String, double>, double>([double.nan].map(box), unbox), null);
    expect(
        minBy<Map<String, double>, double>(
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
