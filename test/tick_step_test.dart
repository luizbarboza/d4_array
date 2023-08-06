import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("tickStep(start, stop, count) returns NaN if any argument is NaN", () {
    expect(tickStep(double.nan, 1, 1), isNaN);
    expect(tickStep(0, double.nan, 1), isNaN);
    expect(tickStep(0, 1, double.nan), isNaN);
    expect(tickStep(double.nan, double.nan, 1), isNaN);
    expect(tickStep(0, double.nan, double.nan), isNaN);
    expect(tickStep(double.nan, 1, double.nan), isNaN);
    expect(tickStep(double.nan, double.nan, double.nan), isNaN);
  });

  test("tickStep(start, stop, count) returns NaN or 0 if start === stop", () {
    expect(tickStep(1, 1, -1), isNaN);
    expect(tickStep(1, 1, 0), isNaN);
    expect(tickStep(1, 1, double.nan), isNaN);
    expect(tickStep(1, 1, 1), isZero);
    expect(tickStep(1, 1, 10), isZero);
  });

  test(
      "tickStep(start, stop, count) returns 0 or Infinity if count is not positive",
      () {
    expect(tickStep(0, 1, -1), double.infinity);
    expect(tickStep(0, 1, 0), double.infinity);
  });

  test("tickStep(start, stop, count) returns 0 if count is infinity", () {
    expect(tickStep(0, 1, double.infinity), 0);
  });

  test(
      "tickStep(start, stop, count) returns approximately count + 1 tickStep when start < stop",
      () {
    expect(tickStep(0, 1, 10), 0.1);
    expect(tickStep(0, 1, 9), 0.1);
    expect(tickStep(0, 1, 8), 0.1);
    expect(tickStep(0, 1, 7), 0.2);
    expect(tickStep(0, 1, 6), 0.2);
    expect(tickStep(0, 1, 5), 0.2);
    expect(tickStep(0, 1, 4), 0.2);
    expect(tickStep(0, 1, 3), 0.5);
    expect(tickStep(0, 1, 2), 0.5);
    expect(tickStep(0, 1, 1), 1.0);
    expect(tickStep(0, 10, 10), 1);
    expect(tickStep(0, 10, 9), 1);
    expect(tickStep(0, 10, 8), 1);
    expect(tickStep(0, 10, 7), 2);
    expect(tickStep(0, 10, 6), 2);
    expect(tickStep(0, 10, 5), 2);
    expect(tickStep(0, 10, 4), 2);
    expect(tickStep(0, 10, 3), 5);
    expect(tickStep(0, 10, 2), 5);
    expect(tickStep(0, 10, 1), 10);
    expect(tickStep(-10, 10, 10), 2);
    expect(tickStep(-10, 10, 9), 2);
    expect(tickStep(-10, 10, 8), 2);
    expect(tickStep(-10, 10, 7), 2);
    expect(tickStep(-10, 10, 6), 5);
    expect(tickStep(-10, 10, 5), 5);
    expect(tickStep(-10, 10, 4), 5);
    expect(tickStep(-10, 10, 3), 5);
    expect(tickStep(-10, 10, 2), 10);
    expect(tickStep(-10, 10, 1), 20);
  });

  test("tickStep(start, stop, count) returns -tickStep(stop, start, count)",
      () {
    expect(tickStep(0, 1, 10), -tickStep(1, 0, 10));
    expect(tickStep(0, 1, 9), -tickStep(1, 0, 9));
    expect(tickStep(0, 1, 8), -tickStep(1, 0, 8));
    expect(tickStep(0, 1, 7), -tickStep(1, 0, 7));
    expect(tickStep(0, 1, 6), -tickStep(1, 0, 6));
    expect(tickStep(0, 1, 5), -tickStep(1, 0, 5));
    expect(tickStep(0, 1, 4), -tickStep(1, 0, 4));
    expect(tickStep(0, 1, 3), -tickStep(1, 0, 3));
    expect(tickStep(0, 1, 2), -tickStep(1, 0, 2));
    expect(tickStep(0, 1, 1), -tickStep(1, 0, 1));
    expect(tickStep(0, 10, 10), -tickStep(10, 0, 10));
    expect(tickStep(0, 10, 9), -tickStep(10, 0, 9));
    expect(tickStep(0, 10, 8), -tickStep(10, 0, 8));
    expect(tickStep(0, 10, 7), -tickStep(10, 0, 7));
    expect(tickStep(0, 10, 6), -tickStep(10, 0, 6));
    expect(tickStep(0, 10, 5), -tickStep(10, 0, 5));
    expect(tickStep(0, 10, 4), -tickStep(10, 0, 4));
    expect(tickStep(0, 10, 3), -tickStep(10, 0, 3));
    expect(tickStep(0, 10, 2), -tickStep(10, 0, 2));
    expect(tickStep(0, 10, 1), -tickStep(10, 0, 1));
    expect(tickStep(-10, 10, 10), -tickStep(10, -10, 10));
    expect(tickStep(-10, 10, 9), -tickStep(10, -10, 9));
    expect(tickStep(-10, 10, 8), -tickStep(10, -10, 8));
    expect(tickStep(-10, 10, 7), -tickStep(10, -10, 7));
    expect(tickStep(-10, 10, 6), -tickStep(10, -10, 6));
    expect(tickStep(-10, 10, 5), -tickStep(10, -10, 5));
    expect(tickStep(-10, 10, 4), -tickStep(10, -10, 4));
    expect(tickStep(-10, 10, 3), -tickStep(10, -10, 3));
    expect(tickStep(-10, 10, 2), -tickStep(10, -10, 2));
    expect(tickStep(-10, 10, 1), -tickStep(10, -10, 1));
  });
}
