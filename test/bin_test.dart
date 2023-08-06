import 'dart:io';

import 'package:d4_array/d4_array.dart';
import 'package:d4_dsv/d4_dsv.dart';
import 'package:test/test.dart';

void main() {
  test("bin() returns a default bin generator", () {
    final h = Bin<num>();
    expect(h.value(42), 42);
    expect(h.domain, extent<num>);
    expect(h.thresholds, thresholdSturges);
  });

  test("bin(data) computes bins of the specified array of data", () {
    final h = Bin();
    expect(
      toList(h.withBounds([0, 0, 0, 10, 20, 20])),
      [
        [
          [0, 0, 0],
          [],
          [10],
          [],
          [20, 20]
        ],
        [(0, 5), (5, 10), (10, 15), (15, 20), (20, 25)]
      ],
    );
  });

  test("bin(iterable) is equivalent to bin(array)", () {
    final h = Bin();
    expect(
      toList(h.withBounds(iterable([0, 0, 0, 10, 20, 20]))),
      [
        [
          [0, 0, 0],
          [],
          [10],
          [],
          [20, 20]
        ],
        [(0, 5), (5, 10), (10, 15), (15, 20), (20, 25)]
      ],
    );
  });

  test("bin.value((_) => number) sets the constant value", () {
    final h = Bin()..value = (_) => 12; // Pointless, but for consistency.
    expect(toList(h.withBounds([0, 0, 0, 1, 2, 2])), [
      [
        [0, 0, 0, 1, 2, 2],
      ],
      [(12, 12)]
    ]);
  });

  test("bin(data) does not bin null, or NaN", () {
    final h = Bin();
    expect(toList(h.withBounds([0, null, null, double.nan, 10, 20, 20])), [
      [
        [0],
        [],
        [10],
        [],
        [20, 20]
      ],
      [(0, 5), (5, 10), (10, 15), (15, 20), (20, 25)]
    ]);
  });

  test("bin.value(function) sets the value accessor", () {
    final h = BinBy<Map<String, int>, int>((d) => d["value"]!);
    const a = {"value": 0};
    const b = {"value": 10};
    const c = {"value": 20};
    expect(
      toList(h.withBounds([a, a, a, b, c, c])),
      [
        [
          [a, a, a],
          [],
          [b],
          [],
          [c, c]
        ],
        [(0, 5), (5, 10), (10, 15), (15, 20), (20, 25)]
      ],
    );
  });

  test("bin.domain(array) sets the domain", () {
    final h = Bin()..constDomain((0, 20));
    expect(h.domain([]), (0, 20));
    expect(toList(h.withBounds([1, 2, 2, 10, 18, 18])), [
      [
        [1, 2, 2],
        [],
        [10],
        [18, 18]
      ],
      [(0, 5), (5, 10), (10, 15), (15, 20)]
    ]);
  });

  test("bin.domain(function) sets the domain accessor", () {
    late Iterable<num?> actual;

    const values = [1, 2, 2, 10, 18, 18];

    (num?, num?) domain(Iterable<num?> values) {
      actual = values;
      return (0, 20);
    }

    final h = Bin()..domain = domain;
    expect(h.domain, domain);
    expect(toList(h.withBounds(values)), [
      [
        [1, 2, 2],
        [],
        [10],
        [18, 18]
      ],
      [(0, 5), (5, 10), (10, 15), (15, 20)]
    ]);
    expect(actual, values);
  });

  test("bin.thresholds(number) sets the approximate number of bin thresholds",
      () {
    final h = Bin()..constThresholds(3);
    expect(toList(h.withBounds([0, 0, 0, 10, 30, 30])), [
      [
        [0, 0, 0],
        [10],
        [],
        [30, 30]
      ],
      [(0, 10), (10, 20), (20, 30), (30, 40)]
    ]);
  });

  test("bin.thresholds(array) sets the bin thresholds", () {
    final h = Bin()..constThresholds([10, 20]);
    expect(toList(h.withBounds([0, 0, 0, 10, 30, 30])), [
      [
        [0, 0, 0],
        [10],
        [30, 30]
      ],
      [(0, 10), (10, 20), (20, 30)]
    ]);
  });

  test("bin.thresholds(array) ignores thresholds outside the domain", () {
    final h = Bin()..constThresholds([0, 1, 2, 3, 4]);
    expect(toList(h.withBounds([0, 1, 2, 3])), [
      [
        [0],
        [1],
        [2],
        [3]
      ],
      [(0, 1), (1, 2), (2, 3), (3, 3)]
    ]);
  });

  test("bin.thresholds(function) sets the bin thresholds accessor", () {
    late List<Object> actual;

    final values = [0, 0, 0, 10, 30, 30];

    final h = Bin()
      ..thresholds = (values, x0, x1) {
        actual = [values, x0, x1];
        return [10, 20];
      };
    expect(toList(h.withBounds(values)), [
      [
        [0, 0, 0],
        [10],
        [30, 30]
      ],
      [(0, 10), (10, 20), (20, 30)],
    ]);
    expect(actual, [values, 0, 30]);
    expect(toList((h..thresholds = (_, __, ___) => 5).withBounds(values)), [
      [
        [0, 0, 0],
        [],
        [10],
        [],
        [],
        [],
        [30, 30]
      ],
      [(0, 5), (5, 10), (10, 15), (15, 20), (20, 25), (25, 30), (30, 35)]
    ]);
  });

  test("bin(data) uses nice thresholds", () {
    final h = Bin()
      ..constDomain((0, 1))
      ..constThresholds(5);
    expect(h.withBounds([]).$2,
        [(0.0, 0.2), (0.2, 0.4), (0.4, 0.6), (0.6, 0.8), (0.8, 1.0)]);
  });

  test("bin()() returns bins whose rightmost bin is not too wide", () {
    final h = Bin();
    expect(toList(h.withBounds([9.8, 10, 11, 12, 13, 13.2])), [
      [
        [9.8],
        [10],
        [11],
        [12],
        [13, 13.2]
      ],
      [(9, 10), (10, 11), (11, 12), (12, 13), (13, 14)]
    ]);
  });

  test("bin(data) handles fractional step correctly", () {
    final h = Bin()..constThresholds(10);
    expect(toList(h.withBounds([9.8, 10, 11, 12, 13, 13.2])), [
      [
        [9.8],
        [10],
        [],
        [11],
        [],
        [12],
        [],
        [13, 13.2]
      ],
      [
        (9.5, 10),
        (10, 10.5),
        (10.5, 11),
        (11, 11.5),
        (11.5, 12),
        (12, 12.5),
        (12.5, 13),
        (13, 13.5)
      ]
    ]);
  });

  test(
      "bin(data) handles fractional step correctly with a custom, non-aligned domain",
      () {
    final h = Bin()
      ..constThresholds(10)
      ..constDomain((9.7, 13.3));
    expect(toList(h.withBounds([9.8, 10, 11, 12, 13, 13.2])), [
      [
        [9.8],
        [10],
        [],
        [11],
        [],
        [12],
        [],
        [13, 13.2]
      ],
      [
        (9.7, 10),
        (10, 10.5),
        (10.5, 11),
        (11, 11.5),
        (11.5, 12),
        (12, 12.5),
        (12.5, 13),
        (13, 13.3)
      ]
    ]);
  });

  test(
      "bin(data) handles fractional step correctly with a custom, aligned domain",
      () {
    final h = Bin()
      ..constThresholds(10)
      ..constDomain((9.5, 13.5));
    expect(toList(h.withBounds([9.8, 10, 11, 12, 13, 13.2])), [
      [
        [9.8],
        [10],
        [],
        [11],
        [],
        [12],
        [],
        [13, 13.2]
      ],
      [
        (9.5, 10),
        (10, 10.5),
        (10.5, 11),
        (11, 11.5),
        (11.5, 12),
        (12, 12.5),
        (12.5, 13),
        (13, 13.5)
      ]
    ]);
  });

  test("bin(athletes) produces the expected result", () async {
    final height =
        csvParse(await File("./test/data/athletes.csv").readAsString())
            .$1
            .where((d) => d["height"] != "0" && d["height"] != "")
            .map((d) => num.parse(d["height"]!));
    final bins = (Bin()..constThresholds(57))(height);
    expect(bins.map((b) => b.length), [
      1,
      0,
      0,
      0,
      0,
      0,
      2,
      1,
      2,
      1,
      1,
      4,
      11,
      7,
      13,
      39,
      78,
      93,
      119,
      193,
      354,
      393,
      573,
      483,
      651,
      834,
      808,
      763,
      627,
      648,
      833,
      672,
      578,
      498,
      395,
      425,
      278,
      235,
      182,
      128,
      91,
      69,
      43,
      29,
      21,
      23,
      3,
      3,
      1,
      1,
      1
    ]);
  });

  test("bin(data) assigns floating point values to the correct bins", () {
    for (final n in [
      1,
      2,
      5,
      10,
      20,
      50,
      100,
      200,
      500,
      1000,
      2000,
      5000,
      10000,
      20000,
      50000
    ]) {
      expect((Bin()..constThresholds(n))(ticks(1, 2, n)).map((d) => d.length),
          everyElement(equals(1)));
    }
  });

  test("bin(data) assigns integer values to the correct bins", () {
    expect(toList((Bin()..constDomain((4, 5))).withBounds([5])), [
      [
        [5]
      ],
      [(4, 5)]
    ]);
    const eights = [8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8];
    expect(toList((Bin()..constDomain((3, 8))).withBounds(eights)), [
      [[], [], [], [], eights],
      [(3, 4), (4, 5), (5, 6), (6, 7), (7, 8)],
    ]);
  });

  test("bin(data) does not mutate user-supplied thresholds as an array", () {
    const thresholds = [3, 4, 5, 6];
    final b = Bin()
      ..constDomain((4, 5))
      ..constThresholds(thresholds);
    expect(toList(b.withBounds([5])), [
      [
        [],
        [5]
      ],
      [(4, 5), (5, 5)],
    ]);
    expect(thresholds, [3, 4, 5, 6]);
    expect(b.thresholds([], 0, 0), [3, 4, 5, 6]);
  });

  test("bin(data) does not mutate user-supplied thresholds as a function", () {
    const thresholds = [3, 4, 5, 6];
    final b = Bin()
      ..constDomain((4, 5))
      ..thresholds = (_, __, ___) => thresholds;
    expect(toList(b.withBounds([5])), [
      [
        [],
        [5]
      ],
      [(4, 5), (5, 5)],
    ]);
    expect(thresholds, [3, 4, 5, 6]);
    expect(b.thresholds([], 0, 0), [3, 4, 5, 6]);
  });
}

List<T> toList<T>((T, T) pair) {
  return [pair.$1, pair.$2];
}

Iterable<T> iterable<T>(List<T> array) sync* {
  yield* array;
}
