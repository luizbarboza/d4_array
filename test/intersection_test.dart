import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("intersection(values) returns a set of values", () {
    expect(intersection([1, 2, 3, 2, 1], []), [1, 2, 3]);
  });

  test("intersection(values, other) returns a set of values", () {
    expect(
        intersection([
          1,
          2
        ], [
          [2, 3, 1]
        ]),
        [1, 2]);
    expect(
        intersection([
          2,
          1,
          3
        ], [
          [4, 3, 1]
        ]),
        [1, 3]);
  });

  test("intersection(...values) returns a set of values", () {
    expect(
        intersection([
          1,
          2
        ], [
          [2, 1],
          [2, 3]
        ]),
        [2]);
  });

  test("intersection(...values) accepts iterables", () {
    expect(intersection({1, 2, 3}, []), [1, 2, 3]);
  });

  test("intersection(...values) performs interning", () {
    expect(
        intersection([
          DateTime(2021, 1, 1),
          DateTime(2021, 1, 3)
        ], [
          [DateTime(2021, 1, 1), DateTime(2021, 1, 2)]
        ]),
        [DateTime(2021, 1, 1)]);
  });
}
