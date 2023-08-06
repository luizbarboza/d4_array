/// Returns a list of pairs from consecutive values of the provided [iterable].
///
/// For example:
///
/// ```dart
/// pairs([1, 2, 3, 4]); // returns [[1, 2], [2, 3], [3, 4]]
/// ```
///
/// If the specified iterable has fewer than two values, returns the empty list.
///
/// {@category Transforming data}
List<(T, T)> pairs<T>(Iterable<T> iterable) =>
    pairsWith<T, (T, T)>(iterable, _pair);

/// Returns a list of values yielded by the [reducer] function applied to each
/// pair of consecutive elements from the provided [iterable].
///
/// For example:
///
/// ```dart
/// pairsWith([1, 2, 3, 4], (a, b) => b - a); returns [1, 1, 1];
/// ```
///
/// If the specified iterable has fewer than two elements, returns the empty
/// list.
///
/// {@category Transforming data}
List<R> pairsWith<T, R>(Iterable<T> iterable, R Function(T, T) reducer) {
  final pairs = <R>[];
  late T previous;
  var first = false;
  for (final value in iterable) {
    if (first) pairs.add(reducer(previous, value));
    previous = value;
    first = true;
  }
  return pairs;
}

(T, T) _pair<T>(T a, T b) {
  return (a, b);
}
