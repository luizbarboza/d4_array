import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("cross([] returns an empty array", () {
    expect(cross([]), []);
  });

  test("cross([[]]) returns an empty array", () {
    expect(cross([[]]), []);
  });

  test("cross([[1, 2], []]) returns an empty array", () {
    expect(
        cross([
          [1, 2],
          []
        ]),
        []);
  });

  test("crossWith(strings, f) returns the expected result", () {
    expect(crossWith(["foo".split(""), "bar".split("")], (x) => x[0] + x[1]),
        ["fb", "fa", "fr", "ob", "oa", "or", "ob", "oa", "or"]);
  });

  test("cross([a]) returns the expected result", () {
    expect(
        cross([
          [1, 2]
        ]),
        [
          [1],
          [2]
        ]);
  });

  test("cross([a, b]) returns Cartesian product a×b", () {
    expect(
        cross([
          [1, 2],
          ["x", "y"]
        ]),
        [
          [1, "x"],
          [1, "y"],
          [2, "x"],
          [2, "y"]
        ]);
  });

  test("cross([a, b, c]) returns Cartesian product a×b×c", () {
    expect(
        cross([
          [1, 2],
          [3, 4],
          [5, 6, 7]
        ]),
        [
          [1, 3, 5],
          [1, 3, 6],
          [1, 3, 7],
          [1, 4, 5],
          [1, 4, 6],
          [1, 4, 7],
          [2, 3, 5],
          [2, 3, 6],
          [2, 3, 7],
          [2, 4, 5],
          [2, 4, 6],
          [2, 4, 7]
        ]);
  });

  test("crossWith([a, b], f) invokes the specified function for each pair", () {
    expect(
        crossWith([
          [1, 2],
          ["x", "y"]
        ], (x) => x[0].toString() + (x[1] as String)),
        ["1x", "1y", "2x", "2y"]);
  });

  test("crossWith([a, b, c], f) invokes the specified function for each triple",
      () {
    expect(
        crossWith<int, int>([
          [1, 2],
          [3, 4],
          [5, 6, 7]
        ], (x) => x[0] + x[1] + x[2]),
        [9, 10, 11, 10, 11, 12, 10, 11, 12, 11, 12, 13]);
  });

  test("cross([a, b]) returns Cartesian product a×b of generators", () {
    expect(
        cross([
          generate([1, 2]),
          generate(["x", "y"])
        ]),
        [
          [1, "x"],
          [1, "y"],
          [2, "x"],
          [2, "y"]
        ]);
  });
}

Iterable<T> generate<T>(Iterable<T> values) sync* {
  yield* values;
}
