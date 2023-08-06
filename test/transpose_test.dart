import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("transpose([]) and transpose([[]]) return an empty array", () {
    expect(transpose([]), []);
    expect(transpose([[]]), []);
  });

  test("transpose([[a, b, …]]) returns [[a], [b], …]", () {
    expect(
        transpose([
          [1, 2, 3, 4, 5]
        ]),
        [
          [1],
          [2],
          [3],
          [4],
          [5]
        ]);
  });

  test("transpose([[a1, b1, …], [a2, b2, …]]) returns [[a1, a2], [b1, b2], …]",
      () {
    expect(
        transpose([
          [1, 2],
          [3, 4]
        ]),
        [
          [1, 3],
          [2, 4]
        ]);
    expect(
        transpose([
          [1, 2, 3, 4, 5],
          [2, 4, 6, 8, 10]
        ]),
        [
          [1, 2],
          [2, 4],
          [3, 6],
          [4, 8],
          [5, 10]
        ]);
  });

  test(
      "transpose([[a1, b1, …], [a2, b2, …], [a3, b3, …]]) returns [[a1, a2, a3], [b1, b2, b3], …]",
      () {
    expect(
        transpose([
          [1, 2, 3],
          [4, 5, 6],
          [7, 8, 9]
        ]),
        [
          [1, 4, 7],
          [2, 5, 8],
          [3, 6, 9]
        ]);
  });

  test("transpose(…) ignores extra elements given an irregular matrix", () {
    expect(
        transpose([
          [1, 2],
          [3, 4],
          [5, 6, 7]
        ]),
        [
          [1, 3, 5],
          [2, 4, 6]
        ]);
  });

  test("transpose(…) returns a copy", () {
    final matrix = [
      [1, 2],
      [3, 4]
    ];
    final t = transpose(matrix);
    matrix[0][0] = matrix[0][1] = matrix[1][0] = matrix[1][1] = 0;
    expect(t, [
      [1, 3],
      [2, 4]
    ]);
  });
}
