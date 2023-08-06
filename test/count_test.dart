import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("count() accepts an iterable", () {
    expect(count([1, 2]), 2);
    expect(count({1, 2}), 2);
    expect(count(generate([1, 2])), 2);
  });

  test("count() ignores NaN, null", () {
    expect(count([double.nan, null, 0, 1]), 2);
  });

  test("count() accepts an accessor", () {
    expect(
        countBy([
          {"v": double.nan},
          {},
          {"v": 0},
          {"v": 1}
        ], (d) => d["v"]),
        2);
    expect(
        countBy<dynamic>([
          {"n": "Alice", "age": double.nan},
          {"n": "Bob", "age": 18},
          {"n": "Other"}
        ], (d) => d["age"]),
        1);
  });
}

Iterable<T> generate<T>(Iterable<T> values) sync* {
  yield* values;
}
