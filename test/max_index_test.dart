import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test(
      "maxIndex(array) returns the index of the greatest numeric value for numbers",
      () {
    expect(maxIndex([1]), 0);
    expect(maxIndex([5, 1, 2, 3, 4]), 0);
    expect(maxIndex([20, 3]), 0);
    expect(maxIndex([3, 20]), 1);
  });

  test(
      "maxIndex(array) returns the index of the greatest lexicographic value for strings",
      () {
    expect(maxIndex(["c", "a", "b"]), 0);
    expect(maxIndex(["20", "3"]), 1);
    expect(maxIndex(["3", "20"]), 0);
  });

  test("maxIndex(array) ignores null and NaN", () {
    expect(maxIndex([double.nan, 1, 2, 3, 4, 5]), 5);
    expect(maxIndex([1, 2, 3, 4, 5, double.nan]), 4);
    expect(maxIndex([10, null, 3, null, 5, double.nan]), 0);
    expect(maxIndex([-1, null, -3, null, -5, double.nan]), 0);
  });

  test("maxIndex(array) returns -1 if the array contains no numbers", () {
    expect(maxIndex<Never>([]), -1);
    expect(maxIndex([null]), -1);
    expect(maxIndex([double.nan]), -1);
    expect(maxIndex([double.nan, double.nan]), -1);
  });

  test(
      "maxIndexBy(array, f) returns the index of the greatest numeric value for numbers",
      () {
    expect(maxIndexBy<Map<String, int>, int>([1].map(box), unbox), 0);
    expect(
        maxIndexBy<Map<String, int>, int>([5, 1, 2, 3, 4].map(box), unbox), 0);
    expect(maxIndexBy<Map<String, int>, int>([20, 3].map(box), unbox), 0);
    expect(maxIndexBy<Map<String, int>, int>([3, 20].map(box), unbox), 1);
  });

  test(
      "maxIndexBy(array, f) returns the index of the greatest lexicographic value for strings",
      () {
    expect(
        maxIndexBy<Map<String, String>, String>(
            ["c", "a", "b"].map(box), unbox),
        0);
    expect(maxIndexBy<Map<String, String>, String>(["20", "3"].map(box), unbox),
        1);
    expect(maxIndexBy<Map<String, String>, String>(["3", "20"].map(box), unbox),
        0);
  });

  test("maxIndexBy(array, f) ignores null and NaN", () {
    expect(
        maxIndexBy<Map<String, num>, num>(
            [double.nan, 1, 2, 3, 4, 5].map(box), unbox),
        5);
    expect(
        maxIndexBy<Map<String, num>, num>(
            [1, 2, 3, 4, 5, double.nan].map(box), unbox),
        4);
    expect(
        maxIndexBy<Map<String, num?>, num?>(
            [10, null, 3, null, 5, double.nan].map(box), unbox),
        0);
    expect(
        maxIndexBy<Map<String, num?>, num?>(
            [-1, null, -3, null, -5, double.nan].map(box), unbox),
        0);
  });

  test(
      "maxIndexBy(array, f) returns -1 if the array contains no observed values",
      () {
    expect(
        maxIndexBy<Map<String, Never>, Never>(<Never>[].map(box), unbox), -1);
    expect(maxIndexBy<Map<String, num?>, num?>([null].map(box), unbox), -1);
    expect(
        maxIndexBy<Map<String, double>, double>([double.nan].map(box), unbox),
        -1);
    expect(
        maxIndexBy<Map<String, double>, double>(
            [double.nan, double.nan].map(box), unbox),
        -1);
  });
}

Map<String, T> box<T>(T value) {
  return {"value": value};
}

T unbox<T>(Map<String, T> box) {
  return box["value"] as dynamic;
}
