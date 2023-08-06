import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("superset(values, other) returns true if values is a superset of others",
      () {
    expect(superset([1, 2], [2]), true);
    expect(superset([2, 3], [3, 4]), false);
    expect(superset([1], []), true);
  });

  test("superset(values, other) allows values to be infinite", () {
    expect(superset(odds(), [1, 3, 5]), true);
  });

  test("superset(values, other) allows other to be infinite", () {
    expect(superset([1, 3, 5], repeat([1, 3, 2])), false);
  });

  test("superset(values, other) performs interning", () {
    expect(
        superset([DateTime(2021, 1, 1), DateTime(2021, 1, 2)],
            [DateTime(2021, 1, 2)]),
        true);
    expect(
        superset([DateTime(2021, 1, 2), DateTime(2021, 1, 3)],
            [DateTime(2021, 1, 3), DateTime(2021, 1, 4)]),
        false);
    expect(superset([DateTime(2021, 1, 1)], []), true);
  });
}

Iterable<int> odds() sync* {
  for (var i = 1; true; i += 2) {
    yield i;
  }
}

Iterable<T> repeat<T>(Iterable<T> values) sync* {
  while (true) {
    yield* values;
  }
}
