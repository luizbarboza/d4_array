/// Returns a permutation of the specified [iterable] using the [keys].
///
/// The returned list contains the corresponding value of the [iterable] for
/// each index in the [keys], in order.
///
/// For example:
///
/// ```dart
/// permute(["a", "b", "c"], [1, 2, 0]); // returns ["b", "c", "a"]
/// ```
///
/// It is acceptable to have more keys than iterable values, and for keys to be
/// duplicated or omitted.
///
/// {@category Sorting data}
List<T?> permute<T>(Iterable<T> iterable, Iterable<int> keys) =>
    List.generate(keys.length, (i) {
      var k = keys.elementAt(i);
      return k < 0 || k >= iterable.length ? null : iterable.elementAt(k);
    });

/// Returns a permutation of the specified [map] using the [keys].
///
/// The returned list contains the corresponding value of the [map] for each key
/// in the [keys], in order.
///
/// For example:
///
/// ```dart
/// var object = {"yield": 27, "variety": "Manchuria", "year": 1931, "site": "University Farm"};
/// var fields = ["site", "variety", "yield"];
/// permute(object, fields); // returns ["University Farm", "Manchuria", 27]
/// ```
///
/// It is acceptable to have more keys than map entries, and for keys to be
/// duplicated or omitted.
///
/// {@category Sorting data}
List<V?> permuteMap<K, V>(Map<K, V> map, Iterable<K> keys) =>
    List.generate(keys.length, (i) {
      var k = keys.elementAt(i);
      return map[k];
    });
