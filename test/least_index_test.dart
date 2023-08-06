import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("leastIndex(array) compares using natural order", () {
    expect(leastIndex([0, 1]), 0);
    expect(leastIndex([1, 0]), 1);
    expect(leastIndex(["10", "2"]), 0);
    expect(leastIndex(["2", "10"]), 1);
    expect(leastIndex([2, double.nan, 10]), 0);
    expect(leastIndex([10, 2, double.nan]), 1);
    expect(leastIndex([double.nan, 10, 2]), 2);
  });

  test(
      "leastIndex(array, compare) compares using the specified compare function",
      () {
    const a = {"name": "a"}, b = {"name": "b"};
    expect(leastIndex([a, b], (a, b) => a["name"]!.compareTo(b["name"]!)), 0);
    expect(leastIndex([1, 0], descending), 0);
    expect(leastIndex(["1", "0"], descending), 0);
    expect(leastIndex(["2", "10"], descending), 0);
    expect(leastIndex([2, double.nan, 10], descending), 2);
  });

  test("leastIndexBy(array, accessor) uses the specified accessor function",
      () {
    const a = {"name": "a", "v": 42}, b = {"name": "b", "v": 0.42};
    expect(leastIndexBy([a, b], (d) => d["name"]), 0);
    expect(leastIndexBy([a, b], (d) => d["v"]), 1);
  });

  test("leastIndex(array) returns -1 if the array is empty", () {
    expect(leastIndex([]), -1);
  });

  test(
      "leastIndex(array) returns -1 if the array contains only incomparable values",
      () {
    expect(leastIndex([double.nan, null]), -1);
  });

  test("leastIndexBy(array) returns the first of equal values", () {
    expect(leastIndex([2, 2, 1, 1, 0, 0, 0, 3, 0]), 4);
    expect(leastIndex([3, 2, 2, 1, 1, 0, 0, 0, 3, 0], descending), 0);
  });

  test("leastIndex(array) ignores null", () {
    expect(leastIndex([null, 2, null]), 1);
  });

  test("leastIndexBy(array, accessor) ignores null", () {
    expect(leastIndexBy([null, 2, null], (d) => d), 1);
  });
}
