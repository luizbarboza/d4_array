import 'dart:typed_data';

import 'ascending.dart';
import 'identity.dart';
import 'sort.dart';

/// Returns an list with the rank of each value in the [iterable], i.e., the
/// zero-based index of the value when the iterable is sorted.
///
/// If [comparator] is not specified, it defaults to [ascending].
///
/// Ties (equivalent values) all get the same rank, defined as the first time
/// the value is found.
///
/// Nullish values are sorted to the end and ranked [double.nan].
///
/// {@category Summarizing data}
List<num> rank<T>(Iterable<T> iterable,
        [num Function(T, T) comparator = ascending]) =>
    _rank<T, T>(iterable, identity, comparator);

/// Returns an list with the rank of each element in the [iterable], i.e., the
/// zero-based index of the element when the iterable is sorted based on the
/// values yielded by the [accessor] function.
///
/// If [comparator] is not specified, it defaults to [ascending].
///
/// Ties (equivalent values) all get the same rank, defined as the first time
/// the value is found.
///
/// Nullish values are sorted to the end and ranked [double.nan].
///
/// {@category Summarizing data}
List<num> rankBy<T, R>(Iterable<T> iterable, R Function(T) accessor,
        [num Function(R, R) comparator = ascending]) =>
    _rank<T, R>(iterable, accessor, comparator);

List<num> _rank<T, R>(Iterable<T> iterable, R Function(T) accessor,
    num Function(R, R) comparator) {
  var l = iterable.length,
      V = [for (var i = 0; i < l; i++) accessor(iterable.elementAt(i))];
  final R = List<num>.filled(l, 0);
  compareIndex(int i, int j) => comparator(V[i], V[j]);
  int? k;
  late int r;
  var values = Uint32List(l), i = 0;
  for (var i = 0; i < l; i++) {
    values[i] = i;
  }
  values.sort(comparator == ascending
      ? (i, j) => ascendingDefined(V[i], V[j])
      : compareDefined(compareIndex));
  for (var j in values) {
    final c = compareIndex(j, k ?? j);
    if (c >= 0) {
      if (k == null || c > 0) {
        k = j;
        r = i;
      }
      R[j] = r;
    } else {
      R[j] = double.nan;
    }
    i++;
  }
  return R;
}
