import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("cumsum(array) returns the cumulative sum of the specified numbers", () {
    expect(List.from(cumsum([1])), [1]);
    expect(List.from(cumsum([5, 1, 2, 3, 4])), [5, 6, 8, 11, 15]);
    expect(List.from(cumsum([20, 3])), [20, 23]);
    expect(List.from(cumsum([3, 20])), [3, 23]);
  });

  test("cumsum(array) ignores null and NaN", () {
    expect(
        List.from(cumsum([double.nan, 1, 2, 3, 4, 5])), [0, 1, 3, 6, 10, 15]);
    expect(
        List.from(cumsum([1, 2, 3, 4, 5, double.nan])), [1, 3, 6, 10, 15, 15]);
    expect(List.from(cumsum([10, null, 3, null, 5, double.nan])),
        [10, 10, 13, 13, 18, 18]);
  });

  test("cumsum(array) returns zeros if there are no numbers", () {
    expect(List.from(cumsum([])), []);
    expect(List.from(cumsum([double.nan])), [0]);
    expect(List.from(cumsum([null])), [0]);
    expect(List.from(cumsum([null, double.nan])), [0, 0]);
  });

  test("cumsumBy(array, f) returns the cumsum of the specified numbers", () {
    expect(List.from(cumsumBy<Map<String, int>>([1].map(box), unbox)), [1]);
    expect(
        List.from(cumsumBy<Map<String, int>>([5, 1, 2, 3, 4].map(box), unbox)),
        [5, 6, 8, 11, 15]);
    expect(List.from(cumsumBy<Map<String, int>>([20, 3].map(box), unbox)),
        [20, 23]);
    expect(List.from(cumsumBy<Map<String, int>>([3, 20].map(box), unbox)),
        [3, 23]);
  });

  test("cumsumBy(array, f) ignores null, and NaN", () {
    expect(
        List.from(cumsumBy<Map<String, num>>(
            [double.nan, 1, 2, 3, 4, 5].map(box), unbox)),
        [0, 1, 3, 6, 10, 15]);
    expect(
        List.from(cumsumBy<Map<String, num>>(
            [1, 2, 3, 4, 5, double.nan].map(box), unbox)),
        [1, 3, 6, 10, 15, 15]);
    expect(
        List.from(cumsumBy<Map<String, num?>>(
            [10, null, 3, null, 5, double.nan].map(box), unbox)),
        [10, 10, 13, 13, 18, 18]);
  });

  test("cumsumBy(array, f) returns zeros if there are no numbers", () {
    expect(
        List.from(cumsumBy<Map<String, Never>>(<Never>[].map(box), unbox)), []);
    expect(
        List.from(cumsumBy<Map<String, double>>([double.nan].map(box), unbox)),
        [0]);
    expect(List.from(cumsumBy<Map<String, num?>>([null].map(box), unbox)), [0]);
    expect(
        List.from(
            cumsumBy<Map<String, double?>>([null, double.nan].map(box), unbox)),
        [0, 0]);
  });
}

Map<String, T> box<T>(T value) {
  return {"value": value};
}

T unbox<T>(Map<String, T> box) {
  return box["value"] as dynamic;
}
