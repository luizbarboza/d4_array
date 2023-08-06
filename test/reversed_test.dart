import 'dart:typed_data';

import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("reverse(values) returns a reversed copy", () {
    const input = [1, 3, 2, 5, 4];
    expect(reverse(input), [4, 5, 2, 3, 1]);
    expect(input, [1, 3, 2, 5, 4]); // does not mutate
  });

  test("reverse(values) returns an array", () {
    expect(reverse(Uint8List.fromList([1, 2])), isA<List>());
  });

  test("reverse(values) accepts an iterable", () {
    expect(reverse({1, 2, 3}), [3, 2, 1]);
    expect(reverse((() sync* {
      yield* [1, 3, 2, 5, 4];
    })()), [4, 5, 2, 3, 1]);
    expect(reverse(Uint8List.fromList([1, 3, 2, 5, 4])), [4, 5, 2, 3, 1]);
  });
}
