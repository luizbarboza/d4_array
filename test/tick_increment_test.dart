import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("tickIncrement(start, stop, count) returns NaN if any argument is NaN",
      () {
    expect(tickIncrement(double.nan, 1, 1), isNaN);
    expect(tickIncrement(0, double.nan, 1), isNaN);
    expect(tickIncrement(0, 1, double.nan), isNaN);
    expect(tickIncrement(double.nan, double.nan, 1), isNaN);
    expect(tickIncrement(0, double.nan, double.nan), isNaN);
    expect(tickIncrement(double.nan, 1, double.nan), isNaN);
    expect(tickIncrement(double.nan, double.nan, double.nan), isNaN);
  });

  test(
      "tickIncrement(start, stop, count) returns NaN or -Infinity if start === stop",
      () {
    expect(tickIncrement(1, 1, -1), isNaN);
    expect(tickIncrement(1, 1, 0), isNaN);
    expect(tickIncrement(1, 1, double.nan), isNaN);
    expect(tickIncrement(1, 1, 1), -double.infinity);
    expect(tickIncrement(1, 1, 10), -double.infinity);
  });

  test(
      "tickIncrement(start, stop, count) returns 0 or Infinity if count is not positive",
      () {
    expect(tickIncrement(0, 1, -1), double.infinity);
    expect(tickIncrement(0, 1, 0), double.infinity);
  });

  test(
      "tickIncrement(start, stop, count) returns -Infinity if count is infinity",
      () {
    expect(tickIncrement(0, 1, double.infinity), -double.infinity);
  });

  test(
      "tickIncrement(start, stop, count) returns approximately count + 1 tickIncrement when start < stop",
      () {
    expect(tickIncrement(0, 1, 10), -10);
    expect(tickIncrement(0, 1, 9), -10);
    expect(tickIncrement(0, 1, 8), -10);
    expect(tickIncrement(0, 1, 7), -5);
    expect(tickIncrement(0, 1, 6), -5);
    expect(tickIncrement(0, 1, 5), -5);
    expect(tickIncrement(0, 1, 4), -5);
    expect(tickIncrement(0, 1, 3), -2);
    expect(tickIncrement(0, 1, 2), -2);
    expect(tickIncrement(0, 1, 1), 1);
    expect(tickIncrement(0, 10, 10), 1);
    expect(tickIncrement(0, 10, 9), 1);
    expect(tickIncrement(0, 10, 8), 1);
    expect(tickIncrement(0, 10, 7), 2);
    expect(tickIncrement(0, 10, 6), 2);
    expect(tickIncrement(0, 10, 5), 2);
    expect(tickIncrement(0, 10, 4), 2);
    expect(tickIncrement(0, 10, 3), 5);
    expect(tickIncrement(0, 10, 2), 5);
    expect(tickIncrement(0, 10, 1), 10);
    expect(tickIncrement(-10, 10, 10), 2);
    expect(tickIncrement(-10, 10, 9), 2);
    expect(tickIncrement(-10, 10, 8), 2);
    expect(tickIncrement(-10, 10, 7), 2);
    expect(tickIncrement(-10, 10, 6), 5);
    expect(tickIncrement(-10, 10, 5), 5);
    expect(tickIncrement(-10, 10, 4), 5);
    expect(tickIncrement(-10, 10, 3), 5);
    expect(tickIncrement(-10, 10, 2), 10);
    expect(tickIncrement(-10, 10, 1), 20);
  });
}
