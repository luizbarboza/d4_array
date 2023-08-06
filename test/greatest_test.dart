import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("greatest(array) compares using natural order", () {
    expect(greatest([0, 1]), 1);
    expect(greatest([1, 0]), 1);
    expect(greatest(["10", "2"]), "2");
    expect(greatest(["2", "10"]), "2");
    expect(greatest([2, double.nan, 10]), 10);
    expect(greatest([10, 2, double.nan]), 10);
    expect(greatest([double.nan, 10, 2]), 10);
  });

  test("greatest(array, compare) compares using the specified compare function",
      () {
    const a = {"name": "a"}, b = {"name": "b"};
    expect(greatest([a, b], (a, b) => a["name"]!.compareTo(b["name"]!)),
        {"name": "b"});
    expect(greatest([1, 0], descending), 0);
    expect(greatest(["1", "0"], descending), "0");
    expect(greatest(["2", "10"], descending), "10");
    expect(greatest([2, double.nan, 10], descending), 2);
  });

  test("greatestBy(array, accessor) uses the specified accessor function", () {
    const a = {"name": "a", "v": 42}, b = {"name": "b", "v": 0.42};
    expect(greatestBy([a, b], (d) => d["name"]), b);
    expect(greatestBy([a, b], (d) => d["v"]), a);
  });

  test("greatest(array) returns null if the array is empty", () {
    expect(greatest([]), null);
  });

  test(
      "greatest(array) returns null if the array contains only incomparable values",
      () {
    expect(greatest([double.nan, null]), null);
  });

  test("greatestBy(array) returns the first of equal values", () {
    var i = 0;
    expect(
        greatest([2, 2, 1, 1, 0, 0, 0, 3, 0].map((d) => box(d, i++)),
            descendingValue),
        {"value": 0, "index": 4});
    i = 0;
    expect(
        greatest([3, 2, 2, 1, 1, 0, 0, 0, 3, 0].map((d) => box(d, i++)),
            ascendingValue),
        {"value": 3, "index": 0});
  });

  test("greatest(array) ignores null", () {
    expect(greatest([null, -2, null]), -2);
  });

  test("greatestBy(array, accessor) ignores null", () {
    expect(greatestBy([null, -2, null], (d) => d), -2);
  });
}

Map<String, num> box(num value, int i) {
  return {"value": value, "index": i};
}

num ascendingValue(Map<String, num> a, Map<String, num> b) {
  return a["value"]! - b["value"]!;
}

num descendingValue(Map<String, num> a, Map<String, num> b) {
  return b["value"]! - a["value"]!;
}
