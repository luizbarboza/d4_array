import 'dart:math';

import 'bisect.dart';
import 'constant.dart';
import 'extent.dart';
import 'identity.dart';
import 'nice.dart';
import 'threshold/sturges.dart';
import 'ticks.dart';

/// A bin generator for numerical data.
///
/// Binning groups discrete samples into a smaller number of consecutive,
/// non-overlapping intervals. They are often used to visualize the distribution
/// of numerical data as histograms.
///
/// To bin the objects based on some property, use [BinBy].
///
/// {@category Binning data}
class Bin<T extends num?> extends BinBy<T, T> {
  /// Constructs a new bin generator with the default settings.
  Bin() : super(identity<T>);
}

/// Equivalent do [Bin], except that it allows for customized data processing
/// and flexible binning based on specific attributes of the data elements.
///
/// {@category Binning data}
class BinBy<T, R extends num?> {
  /// A function that is invoked for each element in the input data list when
  /// the bins are generated.
  ///
  /// This is similar to mapping your data to values before invoking the bin
  /// generator, but has the benefit that the input data remains associated with
  /// the returned bins, thereby making it easier to access other fields of the
  /// data.
  R Function(T) value;

  /// Returns the domain of visible values for a given list of data samples when
  /// bins are generated.
  ///
  /// The [domain] function takes a list of data samples as input, and when bins
  /// are generated, it computes and returns the domain of visible values. The
  /// domain is represented in the form of a record (*min*, *max*), where both
  /// *min* and *max* values are inclusive, meaning they are part of the visible
  /// range.
  (num?, num?) Function(Iterable<R>) domain = extent<R>;

  /// Returns a list of bin thresholds or count indicating the boundaries
  /// between bins for a given list of data samples and the domain (min, max).
  ///
  /// The [thresholds] function takes a list of data samples and a domain
  /// represented by the minimum and maximum values (`min` and `max`). It
  /// computes and returns a list of bin *thresholds* or *count* indicating the
  /// number of bins required.
  ///
  /// Thresholds are defined as an list of values \[*x0*, *x1*, …\]. Any value
  /// less than *x0* will be placed in the first bin; any value greater than or
  /// equal to *x0* but less than *x1* will be placed in the second bin; and so
  /// on. Thus, the generated bins will have thresholds.length + 1 bins.
  ///
  /// Any threshold values outside the [domain] are ignored. The first bin's
  /// lower bound is always equal to the minimum domain value, and the last
  /// bin's upper bound is always equal to the maximum domain value.
  ///
  /// If a *count* is specified instead of an list of *thresholds*, then the
  /// [domain] will be uniformly divided into approximately *count* bins; see
  /// [ticks].
  Object Function(Iterable<R>, num, num) thresholds = thresholdSturges;

  /// Constructs a new bin generator with the default settings and the specified
  /// [value] accessor.
  BinBy(this.value);

  /// Bins the given iterable of [data] samples into separate groups (bins),
  /// based on their values or properties.
  ///
  /// The function returns a list of bins, where each bin is represented as a
  /// list containing elements from the input [data] that fall within the
  /// associated bin's boundaries. The length of each bin corresponds to the
  /// number of elements it contains.
  ///
  /// Optionally, an additional function [handleBounds] can be provided to
  /// process a list of bin bounds. The [handleBounds] function takes a list of
  /// records, each containing two values:
  ///
  /// - `x0`: The lower bound of the bin (inclusive).
  /// - `x1`: The upper bound of the bin (exclusive, except for the last bin).
  ///
  /// If [handleBounds] is provided, it allows for custom operations on each
  /// bin's bounds, such as calculating bin statistics or performing additional
  /// computations.
  List<List<T>> call(Iterable<T> data,
      [void Function(List<(num, num)>)? handleBounds]) {
    int i, n = data.length;
    num? x, step;

    var values = data.map(value);
    var (x0, x1) = domain(values);

    if (x0 == null || x1 == null) return [];

    var tz = thresholds(values, x0, x1);

    // Convert number of thresholds into uniform thresholds, and nice the
    // default domain accordingly.
    if (tz is int) {
      final max = x1, tn = tz;
      if (domain == extent<R>) (x0, x1) = nice(x0, x1, tn);
      tz = ticks(x0, x1, tn);

      if ((tz as List<num>).isEmpty) return [];

      // If the domain is aligned with the first tick (which it will by
      // default), then we can use quantization rather than bisection to bin
      // values, which is substantially faster.
      if (tz[0] <= x0) step = tickIncrement(x0, x1, tn);

      // If the last threshold is coincident with the domain’s upper bound, the
      // last bin will be zero-width. If the default domain is used, and this
      // last threshold is coincident with the maximum input value, we can
      // extend the niced upper bound by one tick to ensure uniform bin widths;
      // otherwise, we simply remove the last threshold. Note that we don’t
      // coerce values or the domain to numbers, and thus must be careful to
      // compare order (>=) rather than strict equality (===)!
      if (tz[tz.length - 1] >= x1) {
        if (max >= x1 && domain == extent<R>) {
          final step = tickIncrement(x0, x1, tn);
          if (step.isFinite) {
            if (step > 0) {
              x1 = ((x1 / step).floor() + 1) * step;
            } else if (step < 0) {
              x1 = ((x1 * -step).ceil() + 1) / -step;
            }
          }
        } else {
          tz.removeLast();
        }
      }
    }

    // Remove any thresholds outside the domain.
    // Be careful not to mutate an array owned by the user!
    var m = (tz as List<num>).length, a = 0, b = m;
    while (a < tz.length && tz[a] <= x0) {
      ++a;
    }
    while (b > 0 && tz[b - 1] > x1) {
      --b;
    }
    if (a != 0 || b < m) {
      tz = tz.sublist(a, b);
      m = b - a;
    }

    // Initialize bins.
    var bins = List.generate(m + 1, (_) => <T>[]);

    // Assign data to bins by value, ignoring any outside the domain.
    if (step != null && step.isFinite) {
      if (step > 0) {
        for (i = 0; i < n; ++i) {
          if ((x = values.elementAt(i)) != null && x0 <= x! && x <= x1) {
            bins[min(m, ((x - x0) / step).floor())].add(data.elementAt(i));
          }
        }
      } else if (step < 0) {
        for (i = 0; i < n; ++i) {
          if ((x = values.elementAt(i)) != null && x0 <= x! && x <= x1) {
            final j = ((x0 - x) * step).floor();
            bins[min(m, j + ((j < tz.length && tz[j] <= x) ? 1 : 0))]
                .add(data.elementAt(i)); // handle off-by-one due to rounding
          }
        }
      }
    } else {
      for (i = 0; i < n; ++i) {
        if ((x = values.elementAt(i)) != null && x0 <= x! && x <= x1) {
          bins[bisectRight(tz, x, lo: 0, hi: m)].add(data.elementAt(i));
        }
      }
    }

    handleBounds?.call(List.generate(m + 1, (i) {
      return (
        i > 0 ? (tz as List<num>)[i - 1] : x0!,
        i < m ? (tz as List<num>)[i] : x1!
      );
    }));

    return bins;
  }

  /// Equivalent to the [call] function but additionally returns the computed
  /// bin bounds.
  (List<List<T>>, List<(num, num)>) withBounds(Iterable<T> data) {
    late List<(num, num)> bounds;
    return (call(data, (b) => bounds = b), bounds);
  }

  /// A special setter that defines a constant [Bin.domain] generator given the
  /// specified [domain].
  void constDomain((num?, num?) domain) =>
      this.domain = constant<(num?, num?)>(domain);

  /// A special setter that defines a constant [Bin.thresholds] generator given
  /// the specified [thresholds].
  void constThresholds(Object thresholds) =>
      this.thresholds = constant<Object>(thresholds);
}
