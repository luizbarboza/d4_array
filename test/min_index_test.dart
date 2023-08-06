import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test(
      "minIndex(array) returns the index of the greatest numeric value for numbers",
      () {
    expect(minIndex([1]), 0);
    expect(minIndex([5, 1, 2, 3, 4]), 1);
    expect(minIndex([20, 3]), 1);
    expect(minIndex([3, 20]), 0);
  });

  test(
      "minIndex(array) returns the index of the greatest lexicographic value for strings",
      () {
    expect(minIndex(["c", "a", "b"]), 1);
    expect(minIndex(["20", "3"]), 0);
    expect(minIndex(["3", "20"]), 1);
  });

  test("minIndex(array) ignores null and NaN", () {
    expect(minIndex([double.nan, 1, 2, 3, 4, 5]), 1);
    expect(minIndex([1, 2, 3, 4, 5, double.nan]), 0);
    expect(minIndex([10, null, 3, null, 5, double.nan]), 2);
    expect(minIndex([-1, null, -3, null, -5, double.nan]), 4);
  });

  test("minIndex(array) returns -1 if the array contains no numbers", () {
    expect(minIndex<Never>([]), -1);
    expect(minIndex([null]), -1);
    expect(minIndex([double.nan]), -1);
    expect(minIndex([double.nan, double.nan]), -1);
  });

  test(
      "minIndexBy(array, f) returns the index of the greatest numeric value for numbers",
      () {
    expect(minIndexBy<Map<String, int>, int>([1].map(box), unbox), 0);
    expect(
        minIndexBy<Map<String, int>, int>([5, 1, 2, 3, 4].map(box), unbox), 1);
    expect(minIndexBy<Map<String, int>, int>([20, 3].map(box), unbox), 1);
    expect(minIndexBy<Map<String, int>, int>([3, 20].map(box), unbox), 0);
  });

  test(
      "minIndexBy(array, f) returns the index of the greatest lexicographic value for strings",
      () {
    expect(
        minIndexBy<Map<String, String>, String>(
            ["c", "a", "b"].map(box), unbox),
        1);
    expect(minIndexBy<Map<String, String>, String>(["20", "3"].map(box), unbox),
        0);
    expect(minIndexBy<Map<String, String>, String>(["3", "20"].map(box), unbox),
        1);
  });

  test("minIndexBy(array, f) ignores null and NaN", () {
    expect(
        minIndexBy<Map<String, num>, num>(
            [double.nan, 1, 2, 3, 4, 5].map(box), unbox),
        1);
    expect(
        minIndexBy<Map<String, num>, num>(
            [1, 2, 3, 4, 5, double.nan].map(box), unbox),
        0);
    expect(
        minIndexBy<Map<String, num?>, num?>(
            [10, null, 3, null, 5, double.nan].map(box), unbox),
        2);
    expect(
        minIndexBy<Map<String, num?>, num?>(
            [-1, null, -3, null, -5, double.nan].map(box), unbox),
        4);
  });

  test(
      "minIndexBy(array, f) returns -1 if the array contains no observed values",
      () {
    expect(
        minIndexBy<Map<String, Never>, Never>(<Never>[].map(box), unbox), -1);
    expect(minIndexBy<Map<String, num?>, num?>([null].map(box), unbox), -1);
    expect(
        minIndexBy<Map<String, double>, double>([double.nan].map(box), unbox),
        -1);
    expect(
        minIndexBy<Map<String, double>, double>(
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
