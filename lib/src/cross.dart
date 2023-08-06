import 'identity.dart';

/// Returns the
/// [Cartesian product](https://en.wikipedia.org/wiki/Cartesian_product) of the
/// specified [iterables].
///
/// For example, if two iterables *a* and *b* are specified, for each element
/// *i* in the iterable *a* and each element *j* in the iterable *b*, in order,
/// creates a two-element array \[*i*, *j*\].
///
/// For example:
///
/// ```dart
/// cross([[1, 2], ["x", "y"]]); // returns [[1, "x"], [1, "y"], [2, "x"], [2, "y"]]
/// ```
///
/// {@category Transforming data}
List<List<T>> cross<T>(Iterable<Iterable<T>> iterables) =>
    crossWith<T, List<T>>(iterables, identity);

/// Returns the
/// [Cartesian product](https://en.wikipedia.org/wiki/Cartesian_product) of the
/// specified [iterables], applying the specified [reducer] function to each
/// combination of elements.
///
/// For example, if two iterables *a* and *b* are specified, for each element
/// *i* in the iterable *a* and each element *j* in the iterable *b*, in order,
/// invokes the specified reducer function passing a two-element array
/// \[*i*, *j*\].
///
/// For example:
///
/// ```dart
/// crossWith([[1, 2], ["x", "y"]], (d) => d[0].toString() + (d[1] as String)); // returns ["1x", "1y", "2x", "2y"]
/// ```
///
/// {@category Transforming data}
List<R> crossWith<T, R>(
    Iterable<Iterable<T>> iterables, R Function(List<T>) reducer) {
  final lengths = iterables.map((i) => i.length);
  final j = iterables.length - 1;
  final index = List.filled(j + 1, 0);
  final product = <List<T>>[];
  if (j < 0 || lengths.any((l) => l == 0)) return [];
  while (true) {
    product.add([
      for (var i = 0; i < j + 1; i++) iterables.elementAt(i).elementAt(index[i])
    ]);
    var i = j;
    while (++index[i] == lengths.elementAt(i)) {
      if (i == 0) return product.map(reducer).toList();
      index[i--] = 0;
    }
  }
}
