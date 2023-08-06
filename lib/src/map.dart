/// Returns a new list containing the mapped values from [iterable], in order,
/// as defined by given [mapper] function.
///
/// Equivalent to [List.map], except that it returns a list instead of an
/// iterable:
///
/// ```dart
/// map({0, 2, 3, 4}, (x) => x.isOdd); // [false, false, true, false]
/// ```
///
/// {@category Transforming data}
List<R> map<T, R>(Iterable<T> iterable, R Function(T) mapper) =>
    iterable.map(mapper).toList();
