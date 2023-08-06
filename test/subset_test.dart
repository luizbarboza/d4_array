import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("subset(values, other) returns true if values is a subset of others",
      () {
    expect(subset([2], [1, 2]), true);
    expect(subset([3, 4], [2, 3]), false);
    expect(subset([], [1]), true);
  });

  test("subset(values, other) performs interning", () {
    expect(
        subset([DateTime(2021, 1, 2)],
            [DateTime(2021, 1, 1), DateTime(2021, 1, 2)]),
        true);
    expect(
        subset([DateTime(2021, 1, 3), DateTime(2021, 1, 4)],
            [DateTime(2021, 1, 2), DateTime(2021, 1, 3)]),
        false);
    expect(subset([], [DateTime(2021, 1, 1)]), true);
  });
}
