import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("sum(array) returns the sum of the specified numbers", () {
    expect(sum([1]), 1);
    expect(sum([5, 1, 2, 3, 4]), 15);
    expect(sum([20, 3]), 23);
    expect(sum([3, 20]), 23);
  });

  test("sum(array) ignores null and NaN", () {
    expect(sum([double.nan, 1, 2, 3, 4, 5]), 15);
    expect(sum([1, 2, 3, 4, 5, double.nan]), 15);
    expect(sum([10, null, 3, null, 5, double.nan]), 18);
  });

  test("sum(array) returns zero if there are no numbers", () {
    expect(sum([]), 0);
    expect(sum([double.nan]), 0);
    expect(sum([null]), 0);
    expect(sum([null, double.nan]), 0);
  });

  test("sumBy(array, f) returns the sum of the specified numbers", () {
    expect(sumBy<Map<String, int>>([1].map(box), unbox), 1);
    expect(sumBy<Map<String, int>>([5, 1, 2, 3, 4].map(box), unbox), 15);
    expect(sumBy<Map<String, int>>([20, 3].map(box), unbox), 23);
    expect(sumBy<Map<String, int>>([3, 20].map(box), unbox), 23);
  });

  test("sumBy(array, f) ignores null and NaN", () {
    expect(sumBy<Map<String, num>>([double.nan, 1, 2, 3, 4, 5].map(box), unbox),
        15);
    expect(sumBy<Map<String, num>>([1, 2, 3, 4, 5, double.nan].map(box), unbox),
        15);
    expect(
        sumBy<Map<String, int?>>([10, null, 3, null, 5, null].map(box), unbox),
        18);
  });

  test("sumBy(array, f) returns zero if there are no numbers", () {
    expect(sumBy<Map<String, Never>>(<Never>[].map(box), unbox), 0);
    expect(sumBy<Map<String, double>>([double.nan].map(box), unbox), 0);
    expect(sumBy<Map<String, num?>>([null].map(box), unbox), 0);
    expect(sumBy<Map<String, double?>>([null, double.nan].map(box), unbox), 0);
  });
}

Map<String, T> box<T>(T value) {
  return {"value": value};
}

T unbox<T>(Map<String, T> box) {
  return box["value"] as dynamic;
}
