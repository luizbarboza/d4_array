import 'dart:typed_data';

import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("sort(values) returns a sorted copy", () {
    const input = [1, 3, 2, 5, 4];
    expect(sort(input), [1, 2, 3, 4, 5]);
    expect(input, [1, 3, 2, 5, 4]); // does not mutate
  });

  test("sort(values) defaults to ascending, not lexicographic", () {
    const input = [1, 10, 2];
    expect(sort(input), [1, 2, 10]);
  });

  test("sort(values) puts non-orderable values last", () {
    const input = [1, null, 0, double.nan, 10, 2];
    expect(sort(input), [0, 1, 2, 10, null, isNaN]);
  });

  test("sort(values, comparator) puts non-orderable values last", () {
    const input = [1, null, 0, double.nan, 10, 2];
    expect(sort(input, ascending), [0, 1, 2, 10, null, isNaN]);
    expect(sort(input, descending), [10, 2, 1, 0, null, isNaN]);
  });

  test("sortBy(values, accessor) puts non-orderable values last", () {
    const input = [1, null, 0, double.nan, 10, 2];
    expect(sortBy(input, (d) => d), [0, 1, 2, 10, null, isNaN]);
    expect(
        sortBy(input, (d) => d != null ? -d : d), [10, 2, 1, 0, null, isNaN]);
  });

  test("sortBy(values, accessor) uses the specified accessor in natural order",
      () {
    expect(sortBy([1, 3, 2, 5, 4], (d) => d), [1, 2, 3, 4, 5]);
    expect(sortBy([1, 3, 2, 5, 4], (d) => -d), [5, 4, 3, 2, 1]);
  });

  test("sort(values, comparator) uses the specified comparator", () {
    expect(sort([1, 3, 2, 5, 4], descending), [5, 4, 3, 2, 1]);
  });

  test("sort(values) returns an array", () {
    expect(sort(Uint8List.fromList([1, 2])), isA<List>());
  });

  test("sort(values) accepts an iterable", () {
    expect(sort({1, 3, 2}), [1, 2, 3]);
    expect(sort((() sync* {
      yield* [1, 3, 2, 5, 4];
    })()), [1, 2, 3, 4, 5]);
    expect(sort(Uint8List.fromList([1, 3, 2, 5, 4])), [1, 2, 3, 4, 5]);
  });
}
