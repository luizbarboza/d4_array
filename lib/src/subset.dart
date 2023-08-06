import 'superset.dart';

/// Returns true if [a] is a subset of [b]\: if every value in the given
/// iterable [a] is also in the given iterable [b].
///
/// ```dart
/// subset([1, 3], [0, 2, 1, 3, 0]); // true
/// ```
///
/// {@category Set operations}
bool subset<T>(Iterable<Object?> a, Iterable<Object?> b) {
  return superset(b, a);
}
