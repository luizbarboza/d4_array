/// Returns true if [a] and [b] are disjoint: if [a] and [b] contain no shared
/// value.
///
/// ```dart
/// disjoint([1, 3], [2, 4]) // true
/// ```
///
/// {@category Set operations}
bool disjoint<T>(Iterable<Object?> a, Iterable<Object?> b) {
  final iterator = b.iterator, set = <Object?>{};
  for (final v in a) {
    if (set.contains(v)) return false;
    while (iterator.moveNext()) {
      var current = iterator.current;
      if (current == v) return false;
      set.add(current);
    }
  }
  return true;
}
