import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("ascending(a, b) returns a negative number if a < b", () {
    expect(ascending(0, 1), lessThan(0));
    expect(ascending("a", "b"), lessThan(0));
  });

  test("ascending(a, b) returns a positive number if a > b", () {
    expect(ascending(1, 0), greaterThan(0));
    expect(ascending("b", "a"), greaterThan(0));
  });

  test("ascending(a, b) returns zero if a >= b and a <= b", () {
    expect(ascending(0, 0), isZero);
    expect(ascending("a", "a"), isZero);
  });

  test("ascending(a, b) returns NaN if a and b are not comparable", () {
    expect(ascending(0, null), isNaN);
    expect(ascending(null, 0), isNaN);
    expect(ascending(null, null), isNaN);
    expect(ascending(0, double.nan), isNaN);
    expect(ascending(double.nan, 0), isNaN);
    expect(ascending(double.nan, double.nan), isNaN);
  });
}
