import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("nice(start, stop, count) returns [start, stop] if any argument is NaN",
      () {
    expect(toList(nice(double.nan, 1, 1)), [isNaN, 1]);
    expect(toList(nice(0, double.nan, 1)), [0, isNaN]);
    expect(nice(0, 1, double.nan), (0, 1));
    expect(toList(nice(double.nan, double.nan, 1)), [isNaN, isNaN]);
    expect(toList(nice(0, double.nan, double.nan)), [0, isNaN]);
    expect(toList(nice(double.nan, 1, double.nan)), [isNaN, 1]);
    expect(toList(nice(double.nan, double.nan, double.nan)), [isNaN, isNaN]);
  });

  test("nice(start, stop, count) returns [start, stop] if start === stop", () {
    expect(nice(1, 1, -1), (1, 1));
    expect(nice(1, 1, 0), (1, 1));
    expect(nice(1, 1, double.nan), (1, 1));
    expect(nice(1, 1, 1), (1, 1));
    expect(nice(1, 1, 10), (1, 1));
  });

  test(
      "nice(start, stop, count) returns [start, stop] if count is not positive",
      () {
    expect(nice(0, 1, -1), (0, 1));
    expect(nice(0, 1, 0), (0, 1));
  });

  test("nice(start, stop, count) returns [start, stop] if count is infinity",
      () {
    expect(nice(0, 1, double.infinity), (0, 1));
  });

  test("nice(start, stop, count) returns the expected values", () {
    expect(nice(0.132, 0.876, 1000), (0.132, 0.876));
    expect(nice(0.132, 0.876, 100), (0.13, 0.88));
    expect(nice(0.132, 0.876, 30), (0.12, 0.88));
    expect(nice(0.132, 0.876, 10), (0.1, 0.9));
    expect(nice(0.132, 0.876, 6), (0.1, 0.9));
    expect(nice(0.132, 0.876, 5), (0, 1));
    expect(nice(0.132, 0.876, 1), (0, 1));
    expect(nice(132, 876, 1000), (132, 876));
    expect(nice(132, 876, 100), (130, 880));
    expect(nice(132, 876, 30), (120, 880));
    expect(nice(132, 876, 10), (100, 900));
    expect(nice(132, 876, 6), (100, 900));
    expect(nice(132, 876, 5), (0, 1000));
    expect(nice(132, 876, 1), (0, 1000));
  });
}

List<T> toList<T>((T, T) x) => [x.$1, x.$2];
