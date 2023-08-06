import 'ascending.dart';

/// Returns the insertion point for [x] in [list] to maintain sorted order
/// according to the specified [comparator].
///
/// The arguments [lo] and [hi] may be used to specify a subset of the list
/// which should be considered; by default the entire list is used. If [x] is
/// already present in [list], the insertion point will be before (to the left
/// of) any existing entries. The return value is suitable for use as the first
/// argument to [List.insert] assuming that [list] is already sorted. The
/// returned insertion point *i* partitions the [list] into two halves so that
/// all *v* < [x] for *v* in [list].sublist([lo], *i*) for the left side and all
/// *v* >= [x] for *v* in [list].sublist(*i*, [hi]) for the right side.
///
/// {@category Bisecting data}
int bisectLeft<T>(List<T> list, T x,
    {int lo = 0, int? hi, num Function(T, T) comparator = ascending}) {
  hi ??= list.length;
  if (lo < hi) {
    if (comparator(x, x) != 0) return hi;
    do {
      var mid = (lo + hi!) >>> 1;
      if (comparator(list[mid], x) < 0) {
        lo = mid + 1;
      } else {
        hi = mid;
      }
    } while (lo < hi);
  }
  return lo;
}

/// Similar to [bisectLeft], but returns an insertion point which comes after
/// (to the right of) any existing entries of [x] in [list].
///
/// The returned insertion point *i* partitions the [list] into two halves so
/// that all *v* <= [x] for *v* in [list].sublist([lo], *i*) for the left side
/// and all *v* > [x] for *v* in [list].sublist(*i*, [hi]) for the right side.
///
/// {@category Bisecting data}
int bisectRight<T>(List<T> list, T x,
    {int lo = 0, int? hi, num Function(T, T) comparator = ascending}) {
  hi ??= list.length;
  if (lo < hi) {
    if (comparator(x, x) != 0) return hi;
    do {
      var mid = (lo + hi!) >>> 1;
      if (comparator(list[mid], x) <= 0) {
        lo = mid + 1;
      } else {
        hi = mid;
      }
    } while (lo < hi);
  }
  return lo;
}

/// Similar to [bisectLeft], but returns the index of the value closest to [x]
/// in the given [list]according to the specified [delta] function.
///
/// If the [delta] function is not specified, it defaults to a function that
/// returns the difference between two values ​​that must be numeric.
///
/// The arguments [lo] (inclusive) and [hi] (exclusive) may be used to specify a
/// subset of the list which should be considered; by default the entire list
/// is used.
///
/// {@category Bisecting data}
int bisectCenter<T>(List<T> list, T x,
    {int lo = 0,
    int? hi,
    num Function(T, T) comparator = ascending,
    num Function(T, T)? delta}) {
  hi ??= list.length;
  delta ??= (a, b) => (a as num) - (b as num);
  var i = bisectLeft(list, x, lo: lo, hi: hi - 1, comparator: comparator);
  return i > lo && delta(list[i - 1], x) > -delta(list[i], x) ? i - 1 : i;
}
