/// Returns true if [a] is a superset of [b]: if every value in the given
/// iterable [b] is also in the given iterable [a].
///
/// ```dart
/// superset([0, 2, 1, 3, 0], [1, 3]); // true
/// ```
///
/// {@category Set operations}
bool superset<T>(Iterable<Object?> a, Iterable<Object?> b) {
  final iterator = a.iterator, set = <Object?>{};
  out:
  for (final o in b) {
    if (set.contains(o)) continue;
    while (iterator.moveNext()) {
      var current = iterator.current;
      set.add(current);
      if (current == o) continue out;
    }
    return false;
  }
  return true;
}
