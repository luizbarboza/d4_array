/// Returns an list containing the values in the given [iterable] in reverse
/// order.
///
/// Equivalent to [List.reversed], except that it returns a list instead of an
/// iterable:
///
/// ```dart
/// reverse({0, 2, 3, 1}); // [1, 3, 2, 0]
/// ```
///
/// {@category Sorting data}
List<T> reverse<T>(Iterable<T> iterable) =>
    [for (var i = iterable.length - 1; i >= 0; i--) iterable.elementAt(i)];
