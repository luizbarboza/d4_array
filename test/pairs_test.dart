import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test(
      "pairs(array) returns the empty array if input array has fewer than two elements",
      () {
    expect(pairs([]), []);
    expect(pairs([1]), []);
  });

  test("pairs(array) returns pairs of adjacent elements in the given array",
      () {
    const a = {}, b = {}, c = {}, d = {};
    expect(
        pairs(
          [1, 2],
        ),
        [(1, 2)]);
    expect(pairs([1, 2, 3]), [(1, 2), (2, 3)]);
    expect(pairs([a, b, c, d]), [(a, b), (b, c), (c, d)]);
  });

  test(
      "pairsWith(array, f) invokes the function f for each pair of adjacent elements",
      () {
    expect(pairsWith([1, 3, 7], (a, b) => b - a), [2, 4]);
  });

  test("pairs(array) includes null or undefined elements in pairs", () {
    expect(pairs([1, null, 2]), [(1, null), (null, 2)]);
    expect(pairs([1, 2, null]), [(1, 2), (2, null)]);
  });
}
