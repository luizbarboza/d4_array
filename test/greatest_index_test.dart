import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("greatestIndex(array) compares using natural order", () {
    expect(greatestIndex([0, 1]), 1);
    expect(greatestIndex([1, 0]), 0);
    expect(greatestIndex(["10", "2"]), 1);
    expect(greatestIndex(["2", "10"]), 0);
    expect(greatestIndex([2, double.nan, 10]), 2);
    expect(greatestIndex([10, 2, double.nan]), 0);
    expect(greatestIndex([double.nan, 10, 2]), 1);
  });

  test(
      "greatestIndex(array, compare) compares using the specified compare function",
      () {
    const a = {"name": "a"}, b = {"name": "b"};
    expect(
        greatestIndex([a, b], (a, b) => a["name"]!.compareTo(b["name"]!)), 1);
    expect(greatestIndex([1, 0], descending), 1);
    expect(greatestIndex(["1", "0"], descending), 1);
    expect(greatestIndex(["2", "10"], descending), 1);
    expect(greatestIndex([2, double.nan, 10], descending), 0);
  });

  test("greatestIndexBy(array, accessor) uses the specified accessor function",
      () {
    const a = {"name": "a", "v": 42}, b = {"name": "b", "v": 0.42};
    expect(greatestIndexBy([a, b], (d) => d["name"]), 1);
    expect(greatestIndexBy([a, b], (d) => d["v"]), 0);
  });

  test("greatestIndex(array) returns -1 if the array is empty", () {
    expect(greatestIndex([]), -1);
  });

  test(
      "greatestIndex(array) returns -1 if the array contains only incomparable values",
      () {
    expect(greatestIndex([double.nan, null]), -1);
  });

  test("greatestIndexBy(array) returns the first of equal values", () {
    expect(greatestIndex([-2, -2, -1, -1, -0, -0, -0, -3, -0]), 4);
    expect(
        greatestIndex([-3, -2, -2, -1, -1, -0, -0, -0, -3, -0], descending), 0);
  });

  test("greatestIndex(array) ignores null", () {
    expect(greatestIndex([null, -2, null]), 1);
  });

  test("greatestIndexBy(array, accessor) ignores null", () {
    expect(greatestIndexBy([null, -2, null], (d) => d), 1);
  });
}
