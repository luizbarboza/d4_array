import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("max(array) returns the greatest numeric value for numbers", () {
    expect(max([1]), 1);
    expect(max([5, 1, 2, 3, 4]), 5);
    expect(max([20, 3]), 20);
    expect(max([3, 20]), 20);
  });

  test("max(array) returns the greatest lexicographic value for strings", () {
    expect(max(["c", "a", "b"]), "c");
    expect(max(["20", "3"]), "3");
    expect(max(["3", "20"]), "3");
  });

  test("max(array) ignores null and NaN", () {
    expect(max([double.nan, 1, 2, 3, 4, 5]), 5);
    expect(max([1, 2, 3, 4, 5, double.nan]), 5);
    expect(max([10, null, 3, null, 5, double.nan]), 10);
    expect(max([-1, null, -3, null, -5, double.nan]), -1);
  });

  test("max(array) returns null if the array contains no numbers", () {
    expect(max<Never>([]), null);
    expect(max([null]), null);
    expect(max([double.nan]), null);
    expect(max([double.nan, double.nan]), null);
  });

  test("maxBy(array, f) returns the greatest numeric value for numbers", () {
    expect(maxBy<Map<String, int>, int>([1].map(box), unbox), 1);
    expect(maxBy<Map<String, int>, int>([5, 1, 2, 3, 4].map(box), unbox), 5);
    expect(maxBy<Map<String, int>, int>([20, 3].map(box), unbox), 20);
    expect(maxBy<Map<String, int>, int>([3, 20].map(box), unbox), 20);
  });

  test("maxBy(array, f) returns the greatest lexicographic value for strings",
      () {
    expect(maxBy<Map<String, String>, String>(["c", "a", "b"].map(box), unbox),
        "c");
    expect(
        maxBy<Map<String, String>, String>(["20", "3"].map(box), unbox), "3");
    expect(
        maxBy<Map<String, String>, String>(["3", "20"].map(box), unbox), "3");
  });

  test("maxBy(array, f) ignores null and NaN", () {
    expect(
        maxBy<Map<String, num>, num>(
            [double.nan, 1, 2, 3, 4, 5].map(box), unbox),
        5);
    expect(
        maxBy<Map<String, num>, num>(
            [1, 2, 3, 4, 5, double.nan].map(box), unbox),
        5);
    expect(
        maxBy<Map<String, num?>, num?>(
            [10, null, 3, null, 5, double.nan].map(box), unbox),
        10);
    expect(
        maxBy<Map<String, num?>, num?>(
            [-1, null, -3, null, -5, double.nan].map(box), unbox),
        -1);
  });

  test("maxBy(array, f) returns null if the array contains no observed values",
      () {
    expect(maxBy<Map<String, Never>, Never>(<Never>[].map(box), unbox), null);
    expect(maxBy<Map<String, num?>, num?>([null].map(box), unbox), null);
    expect(
        maxBy<Map<String, double>, double>([double.nan].map(box), unbox), null);
    expect(
        maxBy<Map<String, double>, double>(
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
