import 'dart:typed_data';

import 'ascending.dart';
import 'permute.dart';

/// Returns an list containing the values in the given [iterable] in the sorted
/// order defined by the given [comparator].
///
/// If [comparator] is not specified, it defaults to [ascending]. Equivalent to
/// [List.sort], except that it does not mutate the given [iterable].
///
/// ```dart
/// sort({0, 2, 3, 1}); // [0, 1, 2, 3]
/// ```
///
/// {@category Sorting data}
List<T> sort<T>(Iterable<T> iterable,
        [num Function(T, T) comparator = ascending]) =>
    List.of(iterable)..sort(compareDefined<T>(comparator));

/// Returns a list containing the elements of the given [iterable] in the sorted
/// order defined by the values yielded by the given [accessor] function.
///
/// If [comparator] is not specified, it defaults to [ascending]. Equivalent to
/// [List.sort], except that it does not mutate the given [iterable].
///
/// ```dart
/// sortBy(data, (d) => d["value"]);
/// ```
///
/// it is equivalent to a [comparator] using natural order:
///
/// ```dart
/// sort(data, (a, b) => ascending(a["value"], b["value"]));
/// ```
///
/// The [accessor] is only invoked once per element, and thus the returned
/// sorted order is consistent even if the accessor is nondeterministic.
///
/// {@category Sorting data}
List<T> sortBy<T, R>(Iterable<T> iterable, R Function(T) accessor,
    [num Function(R, R) comparator = ascending]) {
  final index = Uint32List(iterable.length);
  for (var i = 0; i < iterable.length; i++) {
    index[i] = i;
  }
  var values = iterable.map(accessor), compare = compareDefined(comparator);
  index.sort((i, j) => compare(values.elementAt(i), values.elementAt(j)));
  return List.castFrom(permute(iterable, index));
}

int Function(T, T) compareDefined<T>([num Function(T, T) compare = ascending]) {
  if (compare == ascending) return ascendingDefined;
  return (a, b) {
    final x = compare(a, b);
    if (!x.isNaN) return x.sign.toInt();
    return ((compare(b, b) == 0) ? 1 : 0) - ((compare(a, a) == 0) ? 1 : 0);
  };
}

int ascendingDefined(Object? a, Object? b) {
  var aIsInvalid = ((a == null || a != a) ? 1 : 0),
      bIsInvalid = ((b == null || b != b) ? 1 : 0),
      xor = aIsInvalid - bIsInvalid;
  return xor != 0 || aIsInvalid == 1 ? xor : (a as Comparable).compareTo(b);
}
