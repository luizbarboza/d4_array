/// Returns -1 if [a] is less than [b], or 1 if [a] is greater than [b], or 0.
///
/// This is the comparator function for natural order.
///
/// {@category Sorting data}
num ascending(Object? a, Object? b) {
  return a == null || b == null || a != a || b != b
      ? double.nan
      : (a as Comparable).compareTo(b);
}
