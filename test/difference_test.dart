import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("difference(values, other) returns a set of values", () {
    expect(
        difference([
          1,
          2,
          3
        ], [
          [2, 1]
        ]),
        [3]);
    expect(
        difference([
          1,
          2
        ], [
          [2, 3, 1]
        ]),
        []);
    expect(
        difference([
          2,
          1,
          3
        ], [
          [4, 3, 1]
        ]),
        [2]);
  });

  test("difference(...values) accepts iterables", () {
    expect(
        difference({
          1,
          2,
          3
        }, [
          {1}
        ]),
        [2, 3]);
  });

  test("difference(values, other) performs interning", () {
    expect(
        difference([
          DateTime(2021, 01, 01),
          DateTime(2021, 01, 02),
          DateTime(2021, 01, 03)
        ], [
          [DateTime(2021, 01, 02), DateTime(2021, 01, 01)]
        ]),
        [DateTime(2021, 01, 03)]);
    expect(
        difference([
          DateTime(2021, 01, 01),
          DateTime(2021, 01, 02)
        ], [
          [
            DateTime(2021, 01, 02),
            DateTime(2021, 01, 03),
            DateTime(2021, 01, 01)
          ]
        ]),
        []);
    expect(
        difference([
          DateTime(2021, 01, 02),
          DateTime(2021, 01, 01),
          DateTime(2021, 01, 03)
        ], [
          [
            DateTime(2021, 01, 04),
            DateTime(2021, 01, 03),
            DateTime(2021, 01, 01),
          ]
        ]),
        [DateTime(2021, 01, 02)]);
  });
}
