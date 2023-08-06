import 'ticks.dart';

/// Returns a new interval \[*niceStart*, *niceStop*\] covering the given
/// interval \[[start], [stop]\] and where *niceStart* and *niceStop* are
/// guaranteed to align with the corresponding [tickStep].
///
/// Like [tickIncrement], this requires that [start] is less than or equal to
/// [stop].
///
/// {@category Ticks}
(num, num) nice(num start, num stop, num count) {
  num? prestep;
  while (true) {
    final step = tickIncrement(start, stop, count);
    if (step == prestep || step == 0 || !step.isFinite) {
      return (start, stop);
    } else if (step > 0) {
      start = (start / step).floorToDouble() * step;
      stop = (stop / step).ceilToDouble() * step;
    } else if (step < 0) {
      start = (start * step).ceilToDouble() / step;
      stop = (stop * step).floorToDouble() / step;
    }
    prestep = step;
  }
}
