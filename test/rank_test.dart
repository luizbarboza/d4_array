import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("rank(numbers) returns the rank of numbers", () {
    expect(rank([1000, 10, 0]), [2, 1, 0]);
    expect(rank([1.2, 1.1, 1.2, 1.0, 1.5, 1.2]), [2, 1, 2, 0, 5, 2]);
  });

  test("rank(strings) returns the rank of letters", () {
    expect(rank("EDGFCBA".split("")), [4, 3, 6, 5, 2, 1, 0]);
  });

  test("rank(dates) returns the rank of Dates", () {
    expect(
        rank([DateTime(2000), DateTime(2000), DateTime(1999), DateTime(2001)]),
        [1, 1, 0, 3]);
  });

  test("rank(iterator) accepts an iterator", () {
    expect(rank({"B", "C", "A"}), [1, 2, 0]);
  });

  test("rank(nulls) ranks null as NaN", () {
    expect(rank([1.2, 1.1, null, 1.0, null, 1.5]), [2, 1, isNaN, 0, isNaN, 3]);
    expect(rank([null, null, null, 1.2, 1.1, null, 1.0, double.nan, 1.5]),
        [isNaN, isNaN, isNaN, 2, 1, isNaN, 0, isNaN, 3]);
  });

  test("rankBy(values, valueof) accepts an accessor", () {
    expect(
        rankBy([
          {"x": 3},
          {"x": 1},
          {"x": 2},
          {"x": 4},
          {}
        ], (d) => d["x"]),
        [2, 0, 1, 3, isNaN]);
  });

  test("rank(values, compare) accepts a comparator", () {
    expect(
        rank([
          {"x": 3},
          {"x": 1},
          {"x": 2},
          {"x": 4}
        ], (a, b) => a["x"]! - b["x"]!),
        [2, 0, 1, 3]);
    expect(
        rank([
          {"x": 3},
          {"x": 1},
          {"x": 2},
          {"x": 4}
        ], (a, b) => b["x"]! - a["x"]!),
        [1, 3, 2, 0]);
    expect(
        rank(["aa", "ba", "bc", "bb", "ca"], (a, b) {
          var comp = ascending(a[0], b[0]);
          return comp != 0 ? comp : ascending(a[1], b[1]);
        }),
        [0, 1, 3, 2, 4]);
    expect(rank(["A", "B", "C", "D"], descending), [3, 2, 1, 0]);
  });

  test("rank(values) computes the ties as expected", () {
    expect(rank(["a", "b", "b", "b", "c"]), [0, 1, 1, 1, 4]);
    expect(rank(["a", "b", "b", "b", "b", "c"]), [0, 1, 1, 1, 1, 5]);
  });

  test("rank(values) handles NaNs as expected", () {
    expect(rank(["a", "b", "b", "b", "c", null]), [0, 1, 1, 1, 4, isNaN]);
    expect(
        rank(["a", "b", "b", "b", "b", "c", null]), [0, 1, 1, 1, 1, 5, isNaN]);
  });
}
