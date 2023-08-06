import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("bisectLeft(array, value) returns the index of an exact match", () {
    const numbers = [1, 2, 3];
    expect(bisectLeft(numbers, 1), 0);
    expect(bisectLeft(numbers, 2), 1);
    expect(bisectLeft(numbers, 3), 2);
  });

  test("bisectLeft(array, value) returns the index of the first match", () {
    const numbers = [1, 2, 2, 3];
    expect(bisectLeft(numbers, 1), 0);
    expect(bisectLeft(numbers, 2), 1);
    expect(bisectLeft(numbers, 3), 3);
  });

  test("bisectLeft(empty, value) returns zero", () {
    expect(bisectLeft([], 1), 0);
  });

  test(
      "bisectLeft(array, value) returns the insertion point of a non-exact match",
      () {
    const numbers = [1, 2, 3];
    expect(bisectLeft(numbers, 0.5), 0);
    expect(bisectLeft(numbers, 1.5), 1);
    expect(bisectLeft(numbers, 2.5), 2);
    expect(bisectLeft(numbers, 3.5), 3);
  });

  test(
      "bisectLeft(array, value) has undefined behavior if the search value is unorderable",
      () {
    const numbers = [1, 2, 3];
    bisectLeft(numbers, null);
    bisectLeft(numbers, double.nan);
  });

  test("bisectLeft(array, value, lo) observes the specified lower bound", () {
    const numbers = [1, 2, 3, 4, 5];
    expect(bisectLeft(numbers, 0, lo: 2), 2);
    expect(bisectLeft(numbers, 1, lo: 2), 2);
    expect(bisectLeft(numbers, 2, lo: 2), 2);
    expect(bisectLeft(numbers, 3, lo: 2), 2);
    expect(bisectLeft(numbers, 4, lo: 2), 3);
    expect(bisectLeft(numbers, 5, lo: 2), 4);
    expect(bisectLeft(numbers, 6, lo: 2), 5);
  });

  test("bisectLeft(array, value, lo, hi) observes the specified bounds", () {
    const numbers = [1, 2, 3, 4, 5];
    expect(bisectLeft(numbers, 0, lo: 2, hi: 3), 2);
    expect(bisectLeft(numbers, 1, lo: 2, hi: 3), 2);
    expect(bisectLeft(numbers, 2, lo: 2, hi: 3), 2);
    expect(bisectLeft(numbers, 3, lo: 2, hi: 3), 2);
    expect(bisectLeft(numbers, 4, lo: 2, hi: 3), 3);
    expect(bisectLeft(numbers, 5, lo: 2, hi: 3), 3);
    expect(bisectLeft(numbers, 6, lo: 2, hi: 3), 3);
  });

  test("bisectRight(array, value) returns the index after an exact match", () {
    const numbers = [1, 2, 3];
    expect(bisectRight(numbers, 1), 1);
    expect(bisectRight(numbers, 2), 2);
    expect(bisectRight(numbers, 3), 3);
  });

  test("bisectRight(array, value) returns the index after the last match", () {
    const numbers = [1, 2, 2, 3];
    expect(bisectRight(numbers, 1), 1);
    expect(bisectRight(numbers, 2), 3);
    expect(bisectRight(numbers, 3), 4);
  });

  test("bisectRight(empty, value) returns zero", () {
    expect(bisectRight([], 1), 0);
  });

  test(
      "bisectRight(array, value) returns the insertion point of a non-exact match",
      () {
    const numbers = [1, 2, 3];
    expect(bisectRight(numbers, 0.5), 0);
    expect(bisectRight(numbers, 1.5), 1);
    expect(bisectRight(numbers, 2.5), 2);
    expect(bisectRight(numbers, 3.5), 3);
  });

  test("bisectRight(array, value, lo) observes the specified lower bound", () {
    const numbers = [1, 2, 3, 4, 5];
    expect(bisectRight(numbers, 0, lo: 2), 2);
    expect(bisectRight(numbers, 1, lo: 2), 2);
    expect(bisectRight(numbers, 2, lo: 2), 2);
    expect(bisectRight(numbers, 3, lo: 2), 3);
    expect(bisectRight(numbers, 4, lo: 2), 4);
    expect(bisectRight(numbers, 5, lo: 2), 5);
    expect(bisectRight(numbers, 6, lo: 2), 5);
  });

  test("bisectRight(array, value, lo, hi) observes the specified bounds", () {
    const numbers = [1, 2, 3, 4, 5];
    expect(bisectRight(numbers, 0, lo: 2, hi: 3), 2);
    expect(bisectRight(numbers, 1, lo: 2, hi: 3), 2);
    expect(bisectRight(numbers, 2, lo: 2, hi: 3), 2);
    expect(bisectRight(numbers, 3, lo: 2, hi: 3), 3);
    expect(bisectRight(numbers, 4, lo: 2, hi: 3), 3);
    expect(bisectRight(numbers, 5, lo: 2, hi: 3), 3);
    expect(bisectRight(numbers, 6, lo: 2, hi: 3), 3);
  });

  test(
      "bisectLeft(array, value, lo, hi) keeps non-comparable values to the right",
      () {
    const values = [1, 2, null, null, double.nan];
    expect(bisectLeft(values, 1), 0);
    expect(bisectLeft(values, 2), 1);
    expect(bisectLeft(values, null), 5);
    expect(bisectLeft(values, double.nan), 5);
  });

  test("bisectLeft(array, value, lo, hi) keeps comparable values to the left",
      () {
    const values = [null, null, double.nan];
    expect(bisectLeft(values, 1), 0);
    expect(bisectLeft(values, 2), 0);
  });

  test(
      "bisectRight(array, value, lo, hi) keeps non-comparable values to the right",
      () {
    const values = [1, 2, null, null];
    expect(bisectRight(values, 1), 1);
    expect(bisectRight(values, 2), 2);
    expect(bisectRight(values, null), 4);
    expect(bisectRight(values, double.nan), 4);
  });
}
