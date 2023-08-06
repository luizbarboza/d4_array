import 'package:d4_array/d4_array.dart' as array;
import 'package:test/test.dart';

void main() {
  const data = [
    {"name": "jim", "amount": "34.0", "date": "11/12/2015"},
    {"name": "carl", "amount": "120.11", "date": "11/12/2015"},
    {"name": "stacy", "amount": "12.01", "date": "01/04/2016"},
    {"name": "stacy", "amount": "34.05", "date": "01/04/2016"}
  ];

  test("group(data, accessor) returns the expected map", () {
    expect(array.group(data, (d) => d["name"]), {
      "jim": [
        {"name": "jim", "amount": "34.0", "date": "11/12/2015"}
      ],
      "carl": [
        {"name": "carl", "amount": "120.11", "date": "11/12/2015"}
      ],
      "stacy": [
        {"name": "stacy", "amount": "12.01", "date": "01/04/2016"},
        {"name": "stacy", "amount": "34.05", "date": "01/04/2016"}
      ]
    });
  });

  test("group(data, accessor) returns the expected map", () {
    expect(array.group(data, (d) => (d["name"], d["amount"])), {
      ("jim", "34.0"): [
        {"name": "jim", "amount": "34.0", "date": "11/12/2015"}
      ],
      ("carl", "120.11"): [
        {"name": "carl", "amount": "120.11", "date": "11/12/2015"}
      ],
      ("stacy", "12.01"): [
        {"name": "stacy", "amount": "12.01", "date": "01/04/2016"}
      ],
      ("stacy", "34.05"): [
        {"name": "stacy", "amount": "34.05", "date": "01/04/2016"}
      ]
    });
  });

  test("group(data, accessor) dates", () {
    final a1 = DateTime.utc(2001, 0, 1);
    final a2 = DateTime.utc(2001, 0, 1);
    final b = DateTime.utc(2002, 0, 1);
    final map = array.group([(a1, 1), (a2, 2), (b, 3)], (d) => d.$1);
    expect(map[a1], [(a1, 1), (a2, 2)]);
    expect(map[a2], [(a1, 1), (a2, 2)]);
    expect(map[b], [(b, 3)]);
    expect([...map.keys][0], a1);
    expect([...map.keys][1], b);
  });
}
