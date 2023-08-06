import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("merge(arrays) merges an array of arrays", () {
    const a = {}, b = {}, c = {}, d = {}, e = {}, f = {};
    expect(
        merge([
          [a],
          [b, c],
          [d, e, f]
        ]),
        [a, b, c, d, e, f]);
  });

  test("merge(arrays) returns a new array when zero arrays are passed", () {
    final input = <Iterable>[];
    final output = merge(input);
    expect(output, []);
    input.add([0.1]);
    expect(input, [
      [0.1]
    ]);
    expect(output, []);
  });

  test("merge(arrays) returns a new array when one array is passed", () {
    final input = [
      <num>[1, 2, 3]
    ];
    final output = merge(input);
    expect(output, [1, 2, 3]);
    input.add([4.1]);
    input[0].add(3.1);
    expect(input, [
      [1, 2, 3, 3.1],
      [4.1]
    ]);
    expect(output, [1, 2, 3]);
  });

  test("merge(arrays) returns a new array when two or more arrays are passed",
      () {
    final input = <List<num>>[
      [1, 2, 3],
      [4, 5],
      [6]
    ];
    final output = merge(input);
    expect(output, [1, 2, 3, 4, 5, 6]);
    input.add([7.1]);
    input[0].add(3.1);
    input[1].add(5.1);
    input[2].add(6.1);
    expect(input, [
      [1, 2, 3, 3.1],
      [4, 5, 5.1],
      [6, 6.1],
      [7.1]
    ]);
    expect(output, [1, 2, 3, 4, 5, 6]);
  });

  test("merge(arrays) does not modify the input arrays", () {
    final input = [
      [1, 2, 3],
      [4, 5],
      [6]
    ];
    merge(input);
    expect(input, [
      [1, 2, 3],
      [4, 5],
      [6]
    ]);
  });
}
