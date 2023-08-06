import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("quickselect(array, k) does nothing if k is not a number", () {
    const array = [3, 1, 2];
    expect(quickselect(array, double.nan), array);
    expect(array, [3, 1, 2]);
  });

  test("quickselect(array, k) does nothing if k is less than left", () {
    const array = [3, 1, 2];
    expect(quickselect(array, -1), array);
    expect(array, [3, 1, 2]);
    expect(quickselect(array, -0.5), array);
    expect(array, [3, 1, 2]);
  });

  test("quickselect(array, k) does nothing if k is greater than right", () {
    const array = [3, 1, 2];
    expect(quickselect(array, 3), array);
    expect(array, [3, 1, 2]);
    expect(quickselect(array, 3.4), array);
    expect(array, [3, 1, 2]);
  });

  test("quickselect(array, k) implicitly floors k, left, and right", () {
    expect(quickselect([3, 1, 2], 0.5), [1, 2, 3]);
    expect(quickselect([3, 1, 2, 5, 4], 4.1), [3, 1, 2, 4, 5]);
    expect(quickselect([3, 1, 2], 0, left: 0.5), [1, 2, 3]);
    expect(quickselect([3, 1, 2], 0, left: 0, right: 2.5), [1, 2, 3]);
  });
}
