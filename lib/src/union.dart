/// Returns a new set containing every (distinct) value that appears in any of
/// the given [iterables].
///
/// The order of values in the returned set is based on their first occurrence
/// in the given [iterables].
///
/// ```dart
/// union([[0, 2, 1, 0], [1, 3]]) // {0, 2, 1, 3}
/// ```
///
/// {@category Set operations}
Set<T> union<T>(Iterable<Iterable<T>> iterables) {
  final set = <T>{};
  for (final other in iterables) {
    for (final o in other) {
      set.add(o);
    }
  }
  return set;
}
