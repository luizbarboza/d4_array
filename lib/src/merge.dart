/// Merges the specified iterable of [iterables] into a single list.
///
/// ```dart
/// merge([[1], [2, 3]]); // returns [1, 2, 3]
/// ```
///
/// {@category Transforming data}
List<T> merge<T>(Iterable<Iterable<T>> iterables) =>
    iterables.expand((x) => x).toList();
