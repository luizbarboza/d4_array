/// Returns a new set containing every (distinct) value that appears in all of
/// the given iterables.
///
/// The order of values in the returned set is based on their first occurrence
/// in the given iterables.
///
/// ```dart
/// intersection([0, 2, 1, 0], [[1, 3]]); // {1}
/// ```
///
/// {@category Set operations}
Set<T> intersection<T>(
    Iterable<T> iterable, Iterable<Iterable<Object?>> others) {
  var set = Set.of(iterable);
  for (final other in others) {
    set = set.intersection(Set.of(other));
  }
  return set;
}
