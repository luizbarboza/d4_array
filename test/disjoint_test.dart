import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("disjoint(values, other) returns true if sets are disjoint", () {
    expect(disjoint([1], [2]), true);
    expect(disjoint([2, 3], [3, 4]), false);
    expect(disjoint([1], []), true);
  });

  test("disjoint(values, other) allows values to be infinite", () {
    expect(disjoint(odds(), [0, 2, 4, 5]), false);
  });

  test("disjoint(values, other) allows other to be infinite", () {
    expect(disjoint([2], repeat([1, 3, 2])), false);
  });

  test("disjoint(values, other) performs interning", () {
    expect(disjoint([DateTime(2021, 1, 1)], [DateTime(2021, 1, 2)]), true);
    expect(
        disjoint([DateTime(2021, 1, 2), DateTime(2021, 1, 3)],
            [DateTime(2021, 1, 3), DateTime(2021, 1, 4)]),
        false);
    expect(disjoint([DateTime(2021, 1, 1)], []), true);
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
