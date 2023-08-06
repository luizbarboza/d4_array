import 'dart:math';

import 'sort.dart';

/// See
/// [mourner/quickselect](https://github.com/mourner/quickselect/blob/master/README.md).
///
/// {@category Sorting data}
T quickselect<T extends List<E>, E>(T elements, num k,
    {num left = 0,
    num right = double.infinity,
    int Function(E, E) compare = ascendingDefined}) {
  if (k.isNaN) return elements;
  k = k.floor();
  left = max(0, left).floor();
  right = min(elements.length - 1, right).floor();

  if (!(left <= k && k <= right)) return elements;

  while (right > left) {
    if (right - left > 600) {
      final n = right - left + 1;
      final m = k - left + 1;
      final z = log(n);
      final s = 0.5 * exp(2 * z / 3);
      final sd = 0.5 * sqrt(z * s * (n - s) / n) * (m - n / 2 < 0 ? -1 : 1);
      final newLeft = max(left, (k - m * s / n + sd).floor());
      final newRight = min(right, (k + (n - m) * s / n + sd).floor());
      quickselect(elements, k,
          left: newLeft, right: newRight, compare: compare);
    }

    final t = elements[k as int];
    var i = left as int;
    var j = right as int;

    _swap(elements, left, k);
    if (compare(elements[right], t) > 0) _swap(elements, left, right);

    while (i < j) {
      _swap(elements, i, j);
      ++i;
      --j;
      while (compare(elements[i], t) < 0) {
        ++i;
      }
      while (compare(elements[j], t) > 0) {
        --j;
      }
    }

    if (compare(elements[left], t) == 0) {
      _swap(elements, left, j);
    } else {
      ++j;
      _swap(elements, j, right);
    }

    if (j <= k) left = j + 1;
    if (k <= j) right = j - 1;
  }

  return elements;
}

void _swap<T>(List<T> elements, int i, int j) {
  final t = elements[i];
  elements[i] = elements[j];
  elements[j] = t;
}
