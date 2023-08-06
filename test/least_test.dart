import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  test("least(array) compares using natural order", () {
    expect(least([0, 1]), 0);
    expect(least([1, 0]), 0);
    expect(least(["10", "2"]), "10");
    expect(least(["2", "10"]), "10");
    expect(least([2, double.nan, 10]), 2);
    expect(least([10, 2, double.nan]), 2);
    expect(least([double.nan, 10, 2]), 2);
  });

  test("least(array, compare) compares using the specified compare function",
      () {
    const a = {"name": "a"}, b = {"name": "b"};
    expect(least([a, b], (a, b) => a["name"]!.compareTo(b["name"]!)),
        {"name": "a"});
    expect(least([1, 0], descending), 1);
    expect(least(["1", "0"], descending), "1");
    expect(least(["2", "10"], descending), "2");
    expect(least([2, double.nan, 10], descending), 10);
  });

  test("leastBy(array, accessor) uses the specified accessor function", () {
    const a = {"name": "a", "v": 42}, b = {"name": "b", "v": 0.42};
    expect(leastBy([a, b], (d) => d["name"]), a);
    expect(leastBy([a, b], (d) => d["v"]), b);
  });

  test("least(array) returns null if the array is empty", () {
    expect(least([]), null);
  });

  test(
      "least(array) returns null if the array contains only incomparable values",
      () {
    expect(least([double.nan, null]), null);
  });

  test("leastBy(array) returns the first of equal values", () {
    var i = 0;
    expect(
        least([2, 2, 1, 1, 0, 0, 0, 3, 0].map((d) => box(d, i++)),
            ascendingValue),
        {"value": 0, "index": 4});
    i = 0;
    expect(
        least([3, 2, 2, 1, 1, 0, 0, 0, 3, 0].map((d) => box(d, i++)),
            descendingValue),
        {"value": 3, "index": 0});
  });

  test("least(array) ignores null", () {
    expect(least([null, 2, null]), 2);
  });

  test("leastBy(array, accessor) ignores null", () {
    expect(leastBy([null, 2, null], (d) => d), 2);
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
