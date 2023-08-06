import 'min.dart';

/// Returns a list of lists, where the ith list contains the ith element from
/// each of the iterables in the [matrix].
///
/// The returned list is truncated in length to the shortest iterable in
/// [matrix]. If [matrix] contains only a single iterable, the returned list
/// contains one-element lists. With no iterables in [matrix], the returned list
/// is empty.
///
/// ```dart
/// transpose([[1, 2], [3, 4]]); // returns [[1, 3], [2, 4]]
/// ```
///
/// {@category Transforming data}
List<List<T>> transpose<T>(Iterable<Iterable<T>> matrix) {
  var n = matrix.length;
  if (n == 0) return [];
  var m = minBy<Iterable<T>, int>(matrix, _length<T>)!,
      transpose = List<List<T>>.generate(m,
          (i) => List<T>.generate(n, (j) => matrix.elementAt(j).elementAt(i)));
  return transpose;
}

int _length<T>(Iterable<T> d) {
  return d.length;
}
