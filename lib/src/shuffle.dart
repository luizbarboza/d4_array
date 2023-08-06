import 'dart:math';

import 'number.dart';

final _nextInt = Random().nextInt;

int random() => _nextInt(1);

/// Randomizes the order of the specified [list] in-place using the
/// [Fisher–Yates shuffle](https://bost.ocks.org/mike/shuffle/) and returns the
/// [list].
///
/// If [start] is specified, it is the starting index (inclusive) of the [list]
/// to shuffle; if [start] is not specified, it defaults to zero. If [stop] is
/// specified, it is the ending index (exclusive) of the [list] to shuffle; if
/// [stop] is not specified, it defaults to [list].length. For example, to
/// shuffle the first ten elements of the [list]\: shuffle(list, 0, 10).
///
/// {@category Sorting data}
List<T> shuffle<T>(List<T> list, [int start = 0, int? stop]) =>
    shuffler<T>(random)(list, start, stop);

/// Returns a [shuffle] function given the specified [random] source. For
/// example, using randomLcg:
///
/// ```dart
/// final random = randomLcg(0.9051667019185816);
/// final shuffle = shuffler(random);
/// shuffle([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]); // returns [7, 4, 5, 3, 9, 0, 6, 1, 2, 8]
/// ```
///
/// {@category Sorting data}
List<T> Function(List<T>, [int, int?]) shuffler<T>(num Function() random) {
  return (List<T> values, [int i0 = 0, int? i1]) {
    i1 ??= values.length;
    var m = i1 - i0;
    while (m != 0) {
      final i = toInt32(random() * m--), t = values[m + i0];
      values[m + i0] = values[i + i0];
      values[i + i0] = t;
    }
    return values;
  };
}
