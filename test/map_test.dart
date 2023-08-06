import 'dart:typed_data';

import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("map(values, mapper) returns the mapped values", () {
    expect(map([1, 2, 3, 2, 1], (x) => x * 2), [2, 4, 6, 4, 2]);
  });

  test("map(values, mapper) accepts an iterable", () {
    expect(map({1, 2, 3}, (x) => x * 2), [2, 4, 6]);
    expect(
        map((() sync* {
          yield* [1, 2, 3, 2, 1];
        })(), (x) => x * 2),
        [2, 4, 6, 4, 2]);
  });

  test("map(values, mapper) accepts a typed array", () {
    expect(map(Uint8List.fromList([1, 2, 3, 2, 1]), (x) => x * 2),
        [2, 4, 6, 4, 2]);
  });
}
