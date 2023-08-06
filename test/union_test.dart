import 'dart:typed_data';

import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("union(values) returns a set of values", () {
    expect(
        union([
          [1, 2, 3, 2, 1]
        ]),
        [1, 2, 3]);
  });

  test("union(values, other) returns a set of values", () {
    expect(
        union([
          [1, 2],
          [2, 3, 1]
        ]),
        [1, 2, 3]);
  });

  test("union(...values) returns a set of values", () {
    expect(
        union([
          [1],
          [2],
          [2, 3],
          [1]
        ]),
        [1, 2, 3]);
  });

  test("union(...values) accepts iterables", () {
    expect(
        union([
          {1, 2, 3}
        ]),
        [1, 2, 3]);
    expect(
        union([
          Uint8List.fromList([1, 2, 3])
        ]),
        [1, 2, 3]);
  });

  test("union(...values) performs interning", () {
    expect(
        union([
          [
            DateTime(2021, 01, 01),
            DateTime(2021, 01, 01),
            DateTime(2021, 01, 02)
          ]
        ]),
        [DateTime(2021, 01, 01), DateTime(2021, 01, 02)]);
    expect(
        union([
          [DateTime(2021, 01, 01), DateTime(2021, 01, 03)],
          [DateTime(2021, 01, 01), DateTime(2021, 01, 02)]
        ]),
        [
          DateTime(2021, 01, 01),
          DateTime(2021, 01, 03),
          DateTime(2021, 01, 02)
        ]);
  });
}
