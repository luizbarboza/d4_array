/// Returns a new list containing the values from [iterable], in order, for
/// which the given test function returns true.
///
/// Equivalent to [List.where], except that it returns a list instead of an
/// iterable:
///
/// ```dart
/// filter({0, 2, 3, 4}, (x) => x.isOdd); // [3]
/// ```
///
/// {@category Transforming data}
List<T> filter<T>(Iterable<T> iterable, bool Function(T) test) =>
    iterable.where(test).toList();
