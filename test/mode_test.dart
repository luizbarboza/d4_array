import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("mode(array) returns the most frequent value for numbers", () {
    expect(mode([1]), 1);
    expect(mode([5, 1, 1, 3, 4]), 1);
  });

  test("mode(array) returns the most frequent value for strings", () {
    expect(mode(["1"]), "1");
    expect(mode(["5", "1", "1", "3", "4"]), "1");
  });

  test("mode(array) returns the first of the most frequent values", () {
    expect(mode(["5", "1", "1", "2", "2", "3", "4"]), "1");
  });

  test("mode(array) ignores null and NaN", () {
    expect(mode([double.nan, 1, 1, 3, 4, 5]), 1);
    expect(mode([double.nan, 1, null, null, 1, null]), 1);
    expect(mode([1, double.nan, double.nan, 1, 5, double.nan]), 1);
    expect(mode([1, double.nan, double.nan, 1, 5, double.nan]), 1);
    expect(mode([1, null, null, 1, 5, null]), 1);
  });

  test("mode(array) returns null if the array contains no comparable values",
      () {
    expect(mode([]), null);
    expect(mode([null]), null);
    expect(mode([double.nan]), null);
    expect(mode([double.nan, double.nan]), null);
  });

  test("modeBy(array, f) returns the most frequent value for numbers", () {
    expect(modeBy<Map<String, int>, int>([1].map(box), unbox), 1);
    expect(modeBy<Map<String, int>, int>([5, 1, 1, 3, 4].map(box), unbox), 1);
  });

  test("modeBy(array, f) returns the most frequent value for strings", () {
    expect(modeBy<Map<String, String>, String>(["1"].map(box), unbox), "1");
    expect(
        modeBy<Map<String, String>, String>(
            ["5", "1", "1", "3", "4"].map(box), unbox),
        "1");
  });

  test("modeBy(array, f) returns the first of the most frequent values", () {
    expect(
        modeBy<Map<String, String>, String>(
            ["5", "1", "1", "2", "2", "3", "4"].map(box), unbox),
        "1");
  });

  test("modeBy(array, f) ignores null and NaN", () {
    expect(
        modeBy<Map<String, num>, num>(
            [double.nan, 1, 1, 3, 4, 5].map(box), unbox),
        1);
    expect(
        modeBy<Map<String, num?>, num?>(
            [double.nan, 1, null, null, 1, null].map(box), unbox),
        1);
    expect(
        modeBy<Map<String, num?>, num?>(
            [1, double.nan, double.nan, 1, 5, double.nan].map(box), unbox),
        1);
    expect(
        modeBy<Map<String, int?>, int?>(
            [1, null, null, 1, 5, null].map(box), unbox),
        1);
  });

  test(
      "modeBy(array, f) returns null if the array contains no comparable values",
      () {
    expect(modeBy<Map<String, Never>, Never>(<Never>[].map(box), unbox), null);
    expect(modeBy<Map<String, num?>, num?>([null].map(box), unbox), null);
    expect(modeBy<Map<String, double>, double>([double.nan].map(box), unbox),
        null);
    expect(
        modeBy<Map<String, double>, double>(
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
