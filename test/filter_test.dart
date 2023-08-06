import 'dart:typed_data';

import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("filter(values, test) returns the values that pass the test", () {
    expect(filter([1, 2, 3, 2, 1], (x) => (x & 1) != 0), [1, 3, 1]);
  });

  test("filter(values, test) accepts an iterable", () {
    expect(filter({1, 2, 3}, (x) => (x & 1) != 0), [1, 3]);
    expect(
        filter((() sync* {
          yield* [1, 2, 3, 2, 1];
        })(), (x) => (x & 1) != 0),
        [1, 3, 1]);
  });

  test("filter(values, test) accepts a typed array", () {
    expect(filter(Uint8List.fromList([1, 2, 3, 2, 1]), (x) => (x & 1) != 0),
        [1, 3, 1]);
  });
}
