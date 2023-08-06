import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test(
      "quantileSorted(array, p) requires sorted numeric input, quantile doesn't",
      () {
    expect(quantileSorted([1, 2, 3, 4], 0), 1);
    expect(quantileSorted([1, 2, 3, 4], 1), 4);
    expect(quantileSorted([4, 3, 2, 1], 0), 4);
    expect(quantileSorted([4, 3, 2, 1], 1), 1);
    expect(quantile([1, 2, 3, 4], 0), 1);
    expect(quantile([1, 2, 3, 4], 1), 4);
    expect(quantile([4, 3, 2, 1], 0), 1);
    expect(quantile([4, 3, 2, 1], 1), 4);
  });

  test("quantile() accepts an iterable", () {
    expect(quantile({1, 2, 3, 4}, 1), 4);
  });

  test("quantile(array, p) uses the R-7 method", () {
    const even = [3, 6, 7, 8, 8, 10, 13, 15, 16, 20];
    expect(quantile(even, 0), 3);
    expect(quantile(even, 0.25), 7.25);
    expect(quantile(even, 0.5), 9);
    expect(quantile(even, 0.75), 14.5);
    expect(quantile(even, 1), 20);
    const odd = [3, 6, 7, 8, 8, 9, 10, 13, 15, 16, 20];
    expect(quantile(odd, 0), 3);
    expect(quantile(odd, 0.25), 7.5);
    expect(quantile(odd, 0.5), 9);
    expect(quantile(odd, 0.75), 14);
    expect(quantile(odd, 1), 20);
  });

  test("quantile(array, p) returns an exact value for integer p-values", () {
    const data = [1, 2, 3, 4];
    expect(quantile(data, 1 / 3), 2);
    expect(quantile(data, 2 / 3), 3);
  });

  test(
      "quantile(array, p) returns the expected value for integer or fractional p",
      () {
    const data = [3, 1, 2, 4, 0];
    expect(quantile(data, 0 / 4), 0);
    expect(quantile(data, 0.1 / 4), 0.1);
    expect(quantile(data, 1 / 4), 1);
    expect(quantile(data, 1.5 / 4), 1.5);
    expect(quantile(data, 2 / 4), 2);
    expect(quantile(data, 2.5 / 4), 2.5);
    expect(quantile(data, 3 / 4), 3);
    expect(quantile(data, 3.2 / 4), 3.2);
    expect(quantile(data, 4 / 4), 4);
  });

  test("quantile(array, p) returns the first value for p = 0", () {
    const data = [1, 2, 3, 4];
    expect(quantile(data, 0), 1);
  });

  test("quantile(array, p) returns the last value for p = 1", () {
    const data = [1, 2, 3, 4];
    expect(quantile(data, 1), 4);
  });

  test("quantile(array, p) returns null if p is not a number", () {
    expect(quantile([1, 2, 3], double.nan), null);
  });

  test("quantileBy(array, p, f) observes the specified accessor", () {
    expect(
        quantileBy<Map<String, int>>([1, 2, 3, 4].map(box), 0.5, unbox), 2.5);
    expect(quantileBy<Map<String, int>>([1, 2, 3, 4].map(box), 0, unbox), 1);
    expect(quantileBy<Map<String, int>>([1, 2, 3, 4].map(box), 1, unbox), 4);
    expect(quantileBy<Map<String, int>>([2].map(box), 0, unbox), 2);
    expect(quantileBy<Map<String, int>>([2].map(box), 0.5, unbox), 2);
    expect(quantileBy<Map<String, int>>([2].map(box), 1, unbox), 2);
    expect(quantileBy<Map<String, Never>>([], 0, unbox), null);
    expect(quantileBy<Map<String, Never>>([], 0.5, unbox), null);
    expect(quantileBy<Map<String, Never>>([], 1, unbox), null);
  });

  test("quantileIndex(array, p) returns the index", () {
    expect(quantileIndex([1, 2], 0.2), 0);
    expect(quantileIndex([1, 2, 3], 0.2), 0);
    expect(quantileIndex([1, 3, 2], 0.2), 0);
    expect(quantileIndex([2, 3, 1], 0.2), 2);
    expect(quantileIndex([1], 0.2), 0);
    expect(quantileIndex([], 0.2), -1);
  });

  test("quantileIndex(array, 0) returns the minimum index", () {
    expect(quantileIndex([1, 2], 0), 0);
    expect(quantileIndex([1, 2, 3], 0), 0);
    expect(quantileIndex([1, 3, 2], 0), 0);
    expect(quantileIndex([2, 3, 1], 0), 2);
    expect(quantileIndex([1], 0), 0);
    expect(quantileIndex([], 0), -1);
  });

  test("quantileIndex(array, 1) returns the maximum index", () {
    expect(quantileIndex([1, 2], 1), 1);
    expect(quantileIndex([1, 2, 3], 1), 2);
    expect(quantileIndex([1, 3, 2], 1), 1);
    expect(quantileIndex([2, 3, 1], 1), 1);
    expect(quantileIndex([1], 1), 0);
    expect(quantileIndex([], 1), -1);
  });

  test("quantileIndex(array, 0.5) handles undefined values", () {
    expect(quantileIndex([1, 1, 1, null, 2, 3, 3, 3], 0.5), 4);
    expect(quantileIndexBy([1, 1, 1, null, 2, 3, 3, 3], 0.5, (d) => d), 4);
  });

  test("quantileIndex(array, 0.5) returns the first of equivalent values", () {
    expect(quantileIndex([1, 1, 1, 2, 2, 3, 3, 3], 0.5), 4);
  });
}

Map<String, T> box<T>(T value) {
  return {"value": value};
}

T unbox<T>(Map<String, T> box) {
  return box["value"] as dynamic;
}
