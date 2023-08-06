import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test(
      "ticks(start, stop, count) returns the empty array if any argument is NaN",
      () {
    expect(ticks(double.nan, 1, 1), []);
    expect(ticks(0, double.nan, 1), []);
    expect(ticks(0, 1, double.nan), []);
    expect(ticks(double.nan, double.nan, 1), []);
    expect(ticks(0, double.nan, double.nan), []);
    expect(ticks(double.nan, 1, double.nan), []);
    expect(ticks(double.nan, double.nan, double.nan), []);
  });

  test(
      "ticks(start, stop, count) returns the empty array if start === stop and count is non-positive",
      () {
    expect(ticks(1, 1, -1), []);
    expect(ticks(1, 1, 0), []);
    expect(ticks(1, 1, double.nan), []);
  });

  test(
      "ticks(start, stop, count) returns the empty array if start === stop and count is positive",
      () {
    expect(ticks(1, 1, 1), [1]);
    expect(ticks(1, 1, 10), [1]);
  });

  test(
      "ticks(start, stop, count) returns the empty array if count is not positive",
      () {
    expect(ticks(0, 1, 0), []);
    expect(ticks(0, 1, -1), []);
    expect(ticks(0, 1, double.nan), []);
  });

  test("ticks(start, stop, count) returns the empty array if count is infinity",
      () {
    expect(ticks(0, 1, double.infinity), []);
  });

  test("ticks(start, stop, count) does not include negative zero", () {
    expect(1 / ticks(-1, 0, 5).removeLast(), double.infinity);
  });

  test("ticks(start, stop, count) remains within the domain", () {
    expect(ticks(0, 2.2, 3), [0, 1, 2]);
  });

  test(
      "ticks(start, stop, count) returns approximately count + 1 ticks when start < stop",
      () {
    expect(ticks(0, 1, 10),
        [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]);
    expect(ticks(0, 1, 9),
        [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]);
    expect(ticks(0, 1, 8),
        [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]);
    expect(ticks(0, 1, 7), [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]);
    expect(ticks(0, 1, 6), [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]);
    expect(ticks(0, 1, 5), [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]);
    expect(ticks(0, 1, 4), [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]);
    expect(ticks(0, 1, 3), [0.0, 0.5, 1.0]);
    expect(ticks(0, 1, 2), [0.0, 0.5, 1.0]);
    expect(ticks(0, 1, 1), [0.0, 1.0]);
    expect(ticks(0, 10, 10), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
    expect(ticks(0, 10, 9), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
    expect(ticks(0, 10, 8), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
    expect(ticks(0, 10, 7), [0, 2, 4, 6, 8, 10]);
    expect(ticks(0, 10, 6), [0, 2, 4, 6, 8, 10]);
    expect(ticks(0, 10, 5), [0, 2, 4, 6, 8, 10]);
    expect(ticks(0, 10, 4), [0, 2, 4, 6, 8, 10]);
    expect(ticks(0, 10, 3), [0, 5, 10]);
    expect(ticks(0, 10, 2), [0, 5, 10]);
    expect(ticks(0, 10, 1), [0, 10]);
    expect(ticks(-10, 10, 10), [-10, -8, -6, -4, -2, 0, 2, 4, 6, 8, 10]);
    expect(ticks(-10, 10, 9), [-10, -8, -6, -4, -2, 0, 2, 4, 6, 8, 10]);
    expect(ticks(-10, 10, 8), [-10, -8, -6, -4, -2, 0, 2, 4, 6, 8, 10]);
    expect(ticks(-10, 10, 7), [-10, -8, -6, -4, -2, 0, 2, 4, 6, 8, 10]);
    expect(ticks(-10, 10, 6), [-10, -5, 0, 5, 10]);
    expect(ticks(-10, 10, 5), [-10, -5, 0, 5, 10]);
    expect(ticks(-10, 10, 4), [-10, -5, 0, 5, 10]);
    expect(ticks(-10, 10, 3), [-10, -5, 0, 5, 10]);
    expect(ticks(-10, 10, 2), [-10, 0, 10]);
    expect(ticks(-10, 10, 1), [
      0,
    ]);
  });

  test(
      "ticks(start, stop, count) returns the reverse of ticks(stop, start, count)",
      () {
    expect(ticks(1, 0, 10), ticks(0, 1, 10).reversed);
    expect(ticks(1, 0, 9), ticks(0, 1, 9).reversed);
    expect(ticks(1, 0, 8), ticks(0, 1, 8).reversed);
    expect(ticks(1, 0, 7), ticks(0, 1, 7).reversed);
    expect(ticks(1, 0, 6), ticks(0, 1, 6).reversed);
    expect(ticks(1, 0, 5), ticks(0, 1, 5).reversed);
    expect(ticks(1, 0, 4), ticks(0, 1, 4).reversed);
    expect(ticks(1, 0, 3), ticks(0, 1, 3).reversed);
    expect(ticks(1, 0, 2), ticks(0, 1, 2).reversed);
    expect(ticks(1, 0, 1), ticks(0, 1, 1).reversed);
    expect(ticks(10, 0, 10), ticks(0, 10, 10).reversed);
    expect(ticks(10, 0, 9), ticks(0, 10, 9).reversed);
    expect(ticks(10, 0, 8), ticks(0, 10, 8).reversed);
    expect(ticks(10, 0, 7), ticks(0, 10, 7).reversed);
    expect(ticks(10, 0, 6), ticks(0, 10, 6).reversed);
    expect(ticks(10, 0, 5), ticks(0, 10, 5).reversed);
    expect(ticks(10, 0, 4), ticks(0, 10, 4).reversed);
    expect(ticks(10, 0, 3), ticks(0, 10, 3).reversed);
    expect(ticks(10, 0, 2), ticks(0, 10, 2).reversed);
    expect(ticks(10, 0, 1), ticks(0, 10, 1).reversed);
    expect(ticks(10, -10, 10), ticks(-10, 10, 10).reversed);
    expect(ticks(10, -10, 9), ticks(-10, 10, 9).reversed);
    expect(ticks(10, -10, 8), ticks(-10, 10, 8).reversed);
    expect(ticks(10, -10, 7), ticks(-10, 10, 7).reversed);
    expect(ticks(10, -10, 6), ticks(-10, 10, 6).reversed);
    expect(ticks(10, -10, 5), ticks(-10, 10, 5).reversed);
    expect(ticks(10, -10, 4), ticks(-10, 10, 4).reversed);
    expect(ticks(10, -10, 3), ticks(-10, 10, 3).reversed);
    expect(ticks(10, -10, 2), ticks(-10, 10, 2).reversed);
    expect(ticks(10, -10, 1), ticks(-10, 10, 1).reversed);
  });

  test("ticks(start, stop, count) handles precision problems", () {
    expect(ticks(0.98, 1.14, 10),
        [0.98, 1, 1.02, 1.04, 1.06, 1.08, 1.1, 1.12, 1.14]);
  });

  test(
      "ticks(start, stop, count) tries to return at least one tick if count >= 0.5",
      () {
    expect(ticks(1, 364, 0.1), []);
    expect(ticks(1, 364, 0.499), []);
    expect(ticks(1, 364, 0.5), [200]);
    expect(ticks(1, 364, 1), [200]);
    expect(ticks(1, 364, 1.5), [200]);
    expect(ticks(1, 499, 1), [200, 400]);
    expect(ticks(364, 1, 0.5), [200]);
    expect(ticks(0.001, 0.364, 0.5), [0.2]);
    expect(ticks(0.364, 0.001, 0.5), [0.2]);
    expect(ticks(-1, -364, 0.5), [-200]);
    expect(ticks(-364, -1, 0.5), [-200]);
    expect(ticks(-0.001, -0.364, 0.5), [-0.2]);
    expect(ticks(-0.364, -0.001, 0.5), [-0.2]);
  });
}
