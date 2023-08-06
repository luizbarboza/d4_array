import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test(
      "extent(array) returns the least and the greatest numeric value for numbers",
      () {
    expect(extent([1]), (1, 1));
    expect(extent([5, 1, 2, 3, 4]), (1, 5));
    expect(extent([20, 3]), (3, 20));
    expect(extent([3, 20]), (3, 20));
  });

  test(
      "extent(array) returns the least and the greatest lexicographic value for strings",
      () {
    expect(extent(["c", "a", "b"]), ("a", "c"));
    expect(extent(["20", "3"]), ("20", "3"));
    expect(extent(["3", "20"]), ("20", "3"));
  });

  test("extent(array) ignores null and NaN", () {
    expect(extent([double.nan, 1, 2, 3, 4, 5]), (1, 5));
    expect(extent([1, 2, 3, 4, 5, double.nan]), (1, 5));
    expect(extent([10, null, 3, null, 5, double.nan]), (3, 10));
    expect(extent([-1, null, -3, null, -5, double.nan]), (-5, -1));
  });

  test("extent(array) returns null if the array contains no numbers", () {
    expect(extent<Never>([]), (null, null));
    expect(extent([null]), (null, null));
    expect(extent([double.nan]), (null, null));
    expect(extent([double.nan, double.nan]), (null, null));
  });

  test(
      "extentBy(array, f) returns the least and the greatest numeric value for numbers",
      () {
    expect(extentBy<Map<String, int>, int>([1].map(box), unbox), (1, 1));
    expect(extentBy<Map<String, int>, int>([5, 1, 2, 3, 4].map(box), unbox),
        (1, 5));
    expect(extentBy<Map<String, int>, int>([20, 3].map(box), unbox), (3, 20));
    expect(extentBy<Map<String, int>, int>([3, 20].map(box), unbox), (3, 20));
  });

  test(
      "extentBy(array, f) returns the least and the greatest lexicographic value for strings",
      () {
    expect(
        extentBy<Map<String, String>, String>(["c", "a", "b"].map(box), unbox),
        ("a", "c"));
    expect(extentBy<Map<String, String>, String>(["20", "3"].map(box), unbox),
        ("20", "3"));
    expect(extentBy<Map<String, String>, String>(["3", "20"].map(box), unbox),
        ("20", "3"));
  });

  test("extentBy(array, f) ignores null and NaN", () {
    expect(
        extentBy<Map<String, num>, num>(
            [double.nan, 1, 2, 3, 4, 5].map(box), unbox),
        (1, 5));
    expect(
        extentBy<Map<String, num>, num>(
            [1, 2, 3, 4, 5, double.nan].map(box), unbox),
        (1, 5));
    expect(
        extentBy<Map<String, num?>, num?>(
            [10, null, 3, null, 5, double.nan].map(box), unbox),
        (3, 10));
    expect(
        extentBy<Map<String, num?>, num?>(
            [-1, null, -3, null, -5, double.nan].map(box), unbox),
        (-5, -1));
  });

  test(
      "extentBy(array, f) returns null if the array contains no observed values",
      () {
    expect(extentBy<Map<String, Never>, Never>(<Never>[].map(box), unbox),
        (null, null));
    expect(extentBy<Map<String, num?>, num?>([null].map(box), unbox),
        (null, null));
    expect(extentBy<Map<String, double>, double>([double.nan].map(box), unbox),
        (null, null));
    expect(
        extentBy<Map<String, double>, double>(
            [double.nan, double.nan].map(box), unbox),
        (null, null));
  });
}

Map<String, T> box<T>(T value) {
  return {"value": value};
}

T unbox<T>(Map<String, T> box) {
  return box["value"] as dynamic;
}
