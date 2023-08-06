import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  const data = [
    {"name": "jim", "amount": "3400", "date": "11/12/2015"},
    {"name": "carl", "amount": "12011", "date": "11/12/2015"},
    {"name": "stacy", "amount": "1201", "date": "01/04/2016"},
    {"name": "stacy", "amount": "3405", "date": "01/04/2016"}
  ];

  test("rollup(data, reduce, accessor) returns the expected map", () {
    expect(rollup(data, (v) => v.length, (d) => d["name"]),
        {"jim": 1, "carl": 1, "stacy": 2});
    expect(
        rollup(data, (v) => sumBy(v, (d) => num.parse(d["amount"]!)),
            (d) => d["name"]),
        {"jim": 3400, "carl": 12011, "stacy": 4606});
    expect(rollup(data, (v) => v.length, (d) => (d["name"], d["amount"])), {
      ("jim", "3400"): 1,
      ("carl", "12011"): 1,
      ("stacy", "1201"): 1,
      ("stacy", "3405"): 1
    });
  });
}
