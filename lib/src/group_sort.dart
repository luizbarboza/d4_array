import 'ascending.dart';
import 'group.dart';
import 'sort.dart';

/// Groups the specified [iterable] of elements according to the specified [key]
/// function, sorts the groups according to the specified [valueComparator] for
/// values and [keyComparator] for keys, and then returns a list of keys in
/// sorted order.
///
/// If the comparison of values results in a tie (i.e., comparison returns 0),
/// the [keyComparator] is used to break the tie and determine the order of the
/// keys. If [valueComparator] is not provided, it defaults to [ascending], and
/// if [keyComparator] is not provided, it also defaults to [ascending].
///
/// {@category Grouping data}
List<K> groupSort<T, K>(Iterable<T> iterable, K Function(T) key,
    [num Function(List<T>, List<T>) valueComparator = ascending,
    num Function(K, K) keyComparator = ascending]) {
  return sort(group(iterable, key).entries, (g1, g2) {
    var comp = valueComparator(g1.value, g2.value);
    return comp != 0 ? comp : keyComparator(g1.key, g2.key);
  }).map((e) => e.key).toList();
}

/// Groups and reduces the specified [iterable] of elements according to the
/// specified [key] function, sorts the reduced groups according to the
/// specified [valueComparator] for values and [keyComparator] for keys,
/// and then returns a list of keys in sorted order.
///
/// For example, if you had a table of barley yields for different varieties,
/// sites, and years, to sort the barley varieties by ascending median yield:
///
/// ```dart
/// rollupSort(barley, (d) => d["variety"], (g) => medianBy(g, (d) => d["yield"]));
/// ```
///
/// For descending order, negate the group value:
///
/// ```dart
/// rollupSort(barley, (d) => d["variety"], (g) => -medianBy(g, (d) => d["yield"]));
/// ```
///
/// If the comparison of values results in a tie (i.e., comparison returns 0),
/// the [keyComparator] is used to break the tie and determine the order of the
/// keys. If [valueComparator] is not provided, it defaults to [ascending], and
/// if [keyComparator] is not provided, it also defaults to [ascending].g].
///
/// {@category Grouping data}
List<K> rollupSort<T, R, K>(
    Iterable<T> iterable, R Function(List<T>) reduce, K Function(T) key,
    [num Function(R, R) valueComparator = ascending,
    num Function(K, K) keyComparator = ascending]) {
  return sort(rollup(iterable, reduce, key).entries, (g1, g2) {
    var comp = valueComparator(g1.value, g2.value);
    return comp != 0 ? comp : keyComparator(g1.key, g2.key);
  }).map((e) => e.key).toList();
}
