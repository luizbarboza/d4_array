import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("+adder can be applied several times", () {
    final adder = Adder();
    for (var i = 0; i < 10; ++i) {
      adder.add(0.1);
    }
    expect(adder.valueOf(), 1);
    expect(adder.valueOf(), 1);
  });

  test("fsum(array) is an exact sum", () {
    expect(fsum([.1, .1, .1, .1, .1, .1, .1, .1, .1, .1]), 1);
    expect(
        fsum([
          .3,
          .3,
          .3,
          .3,
          .3,
          .3,
          .3,
          .3,
          .3,
          .3,
          -.3,
          -.3,
          -.3,
          -.3,
          -.3,
          -.3,
          -.3,
          -.3,
          -.3,
          -.3
        ]),
        0);
  });

  test("fsum(array) returns the fsum of the specified numbers", () {
    expect(fsum([1]), 1);
    expect(fsum([5, 1, 2, 3, 4]), 15);
    expect(fsum([20, 3]), 23);
    expect(fsum([3, 20]), 23);
  });

  test("fsum(array) ignores null and NaN", () {
    expect(fsum([double.nan, 1, 2, 3, 4, 5]), 15);
    expect(fsum([1, 2, 3, 4, 5, double.nan]), 15);
    expect(fsum([10, null, 3, null, 5, double.nan]), 18);
  });

  test("fsum(array) returns zero if there are no numbers", () {
    expect(fsum([]), 0);
    expect(fsum([double.nan]), 0);
    expect(fsum([null]), 0);
    expect(fsum([null, double.nan]), 0);
  });

  test("fsumBy(array, f) returns the fsum of the specified numbers", () {
    expect(fsumBy<Map<String, int>>([1].map(box), unbox), 1);
    expect(fsumBy<Map<String, int>>([5, 1, 2, 3, 4].map(box), unbox), 15);
    expect(fsumBy<Map<String, int>>([20, 3].map(box), unbox), 23);
    expect(fsumBy<Map<String, int>>([3, 20].map(box), unbox), 23);
  });

  test("fsumBy(array, f) ignores null and NaN", () {
    expect(
        fsumBy<Map<String, num>>([double.nan, 1, 2, 3, 4, 5].map(box), unbox),
        15);
    expect(
        fsumBy<Map<String, num>>([1, 2, 3, 4, 5, double.nan].map(box), unbox),
        15);
    expect(
        fsumBy<Map<String, num?>>(
            [10, null, 3, null, 5, double.nan].map(box), unbox),
        18);
  });

  test("fsumBy(array, f) returns zero if there are no numbers", () {
    expect(fsumBy<Map<String, Never>>(<Never>[].map(box), unbox), 0);
    expect(fsumBy<Map<String, double>>([double.nan].map(box), unbox), 0);
    expect(fsumBy<Map<String, num?>>([null].map(box), unbox), 0);
    expect(fsumBy<Map<String, double?>>([null, double.nan].map(box), unbox), 0);
  });
}

Map<String, T> box<T>(T value) {
  return {"value": value};
}

T unbox<T>(Map<String, T> box) {
  return box["value"] as dynamic;
}
