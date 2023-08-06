import 'dart:typed_data';

import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("permute(…) permutes according to the specified index", () {
    expect(permute([3, 4, 5], [2, 1, 0]), [5, 4, 3]);
    expect(permute([3, 4, 5], [2, 0, 1]), [5, 3, 4]);
    expect(permute([3, 4, 5], [0, 1, 2]), [3, 4, 5]);
  });

  test("permute(…) does not modify the input array", () {
    const input = [3, 4, 5];
    permute(input, [2, 1, 0]);
    expect(input, [3, 4, 5]);
  });

  test("permute(…) can duplicate input values", () {
    expect(permute([3, 4, 5], [0, 1, 0]), [3, 4, 3]);
    expect(permute([3, 4, 5], [2, 2, 2]), [5, 5, 5]);
    expect(permute([3, 4, 5], [0, 1, 1]), [3, 4, 4]);
  });

  test("permute(…) can return more elements", () {
    expect(permute([3, 4, 5], [0, 0, 1, 2]), [3, 3, 4, 5]);
    expect(permute([3, 4, 5], [0, 1, 1, 1]), [3, 4, 4, 4]);
  });

  test("permute(…) can return fewer elements", () {
    expect(permute([3, 4, 5], [0]), [3]);
    expect(permute([3, 4, 5], [1, 2]), [4, 5]);
    expect(permute([3, 4, 5], []), []);
  });

  test("permute(…) can return null elements", () {
    expect(permute([3, 4, 5], [10]), [null]);
    expect(permute([3, 4, 5], [-1]), [null]);
    expect(permute([3, 4, 5], [0, -1]), [3, null]);
  });

  test("permuteMap(…) can take an object as the source", () {
    expect(permuteMap({"foo": 1, "bar": 2}, ["bar", "foo"]), [2, 1]);
  });

  test("permute(…) can take a typed array as the source", () {
    expect(permute(Float32List.fromList([1, 2]), [0, 0, 1, 0]), [1, 1, 2, 1]);
    expect(permute(Float32List.fromList([1, 2]), [0]), isA<List>());
  });

  test("permuteMap(…) can take an iterable as the keys", () {
    expect(permuteMap({"foo": 1, "bar": 2}, {"bar", "foo"}), [2, 1]);
  });
}
