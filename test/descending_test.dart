import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("descending(a, b) returns a negative number if a < b", () {
    expect(descending(0, 1), greaterThan(0));
    expect(descending("a", "b"), greaterThan(0));
  });

  test("descending(a, b) returns a positive number if a > b", () {
    expect(descending(1, 0), lessThan(0));
    expect(descending("b", "a"), lessThan(0));
  });

  test("descending(a, b) returns zero if a >= b and a <= b", () {
    expect(descending(0, 0), isZero);
    expect(descending("a", "a"), isZero);
  });

  test("descending(a, b) returns NaN if a and b are not comparable", () {
    expect(descending(0, null), isNaN);
    expect(descending(null, 0), isNaN);
    expect(descending(null, null), isNaN);
    expect(descending(0, double.nan), isNaN);
    expect(descending(double.nan, 0), isNaN);
    expect(descending(double.nan, double.nan), isNaN);
  });
}
