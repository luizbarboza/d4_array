/// Returns a new set containing every value in [iterable] that is not in any of
/// the [others] iterables.
///
/// ```dart
/// difference([0, 1, 2, 0], [[1]]); // {0, 2}
/// ```
///
/// {@category Set operations}
Set<T> difference<T>(Iterable<T> iterable, Iterable<Iterable<Object?>> others) {
  var set = Set.of(iterable);
  for (final other in others) {
    for (final o in other) {
      set.remove(o);
    }
  }
  return set;
}
