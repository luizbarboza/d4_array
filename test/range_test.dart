import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("range(stop) returns [0, 1, 2, … stop - 1]", () {
    expect(range(stop: 5), [0, 1, 2, 3, 4]);
    expect(range(stop: 2.01), [0, 1, 2]);
    expect(range(stop: 1), [0]);
    expect(range(stop: .5), [0]);
  });

  test("range(stop) returns an empty array if stop <= 0", () {
    expect(range(stop: 0), []);
    expect(range(stop: -0.5), []);
    expect(range(stop: -1), []);
  });

  test("range(stop) returns an empty array if stop is NaN", () {
    expect(range(stop: double.nan), []);
  });
}
