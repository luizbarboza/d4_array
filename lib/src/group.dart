/// Groups the specified [iterable] of values into an [Map] from [key] to list
/// of value.
///
/// For example, given some data:
///
/// ```dart
/// final data = [
///   {"name": "jim",   "amount": "34.0",   "date": "11/12/2015"},
///   {"name": "carl",  "amount": "120.11", "date": "11/12/2015"},
///   {"name": "stacy", "amount": "12.01",  "date": "01/04/2016"},
///   {"name": "stacy", "amount": "34.05",  "date": "01/04/2016"}
/// ];
/// ```
///
/// To group the data by name:
///
/// ```dart
/// group(data, (d) => d["name"]);
/// ```
///
/// This produces:
///
/// ```dart
/// {
///   "jim": [
///     {"name": "jim", "amount": 34.0, "date": "11/12/2015"}
///   ],
///   "carl": [
///      {"name": "carl", "amount": 120.11, "date": "11/12/2015"}
///   ],
///   "stacy": [
///     {"name": "stacy", "amount": 12.01, "date": "01/04/2016"},
///     {"name": "stacy", "amount": 34.05, "date": "01/04/2016"}
///   ]
/// };
/// ```
///
/// To group by more than one key:
///
/// ```dart
/// group(data, (d) => (d["name"], d["date"]));
/// ```
///
/// This produces:
///
/// ```dart
/// {
///   ("jim", "11/12/2015"): [
///     {"name": "jim", "amount": 34.0, "date": "11/12/2015"}
///   ],
///   ("carl", "11/12/2015"): [
///      {"name": "carl", "amount": 120.11, "date": "11/12/2015"}
///   ],
///   ("stacy", "01/04/2016"): [
///     {"name": "stacy", "amount": 12.01, "date": "01/04/2016"},
///     {"name": "stacy", "amount": 34.05, "date": "01/04/2016"}
///   ]
/// };
/// ```
///
/// {@category Grouping data}
Map<K, List<T>> group<T, K>(Iterable<T> iterable, K Function(T) key) {
  var groups = <K, List<T>>{};
  for (var value in iterable) {
    (groups[key(value)] ??= []).add(value);
  }
  return groups;
}

/// Equivalent to [group] but returns a unique value per compound key instead of
/// an list, throwing if the key is not unique.
///
/// ```dart
/// final data = [
///   {"name": "jim",   "amount": "34.0",   "date": "11/12/2015"},
///   {"name": "carl",  "amount": "120.11", "date": "11/12/2015"},
///   {"name": "stacy", "amount": "12.01",  "date": "01/04/2016"},
///   {"name": "stacy", "amount": "34.05",  "date": "01/04/2016"}
/// ];
/// ```
///
/// For example, given the data defined above,
///
/// ```dart
/// index(data, (d) => d["amount"]);
/// ```
///
/// returns
///
/// ```dart
/// {
///   "34.0": {"name": "jim", "amount": 34.0, "date": "11/12/2015"},
///   "120.11": {"name": "carl", "amount": 120.11, "date": "11/12/2015"},
///   "12.01": {"name": "stacy", "amount": 12.01, "date": "01/04/2016"},
///   "34.05": {"name": "stacy", "amount": 34.05, "date": "01/04/2016"}
/// };
/// ```
///
/// On the other hand,
///
/// ```dart
/// index(data, (d) => d["name"]);
/// ```
///
/// throws an error because two objects share the same name.
///
/// {@category Grouping data}
Map<K, List<T>> index<T, K>(Iterable<T> iterable, K Function(T) key) {
  var groups = <K, List<T>>{};
  for (var value in iterable) {
    if (groups.containsKey(key(value))) throw "duplicate key";
    groups[key(value)] = [value];
  }
  return groups;
}

/// Groups and reduces the specified [iterable] of values into an [Map] from key
/// to value.
///
/// For example, given some data:
///
/// ```dart
/// final data = [
///   {"name": "jim",   "amount": "34.0",   "date": "11/12/2015"},
///   {"name": "carl",  "amount": "120.11", "date": "11/12/2015"},
///   {"name": "stacy", "amount": "12.01",  "date": "01/04/2016"},
///   {"name": "stacy", "amount": "34.05",  "date": "01/04/2016"}
/// ];
/// ```
///
/// To count the number of elements by name:
///
/// ```dart
/// rollup(data, (v) => v["length"], (d) => d["name"])
/// ```
///
/// This produces:
///
/// ```dart
/// {
///   "jim": 1,
///   "carl": 1,
///   "stacy": 2
/// };
/// ```
///
/// To count the number of elements by more than one key:
///
/// ```dart
/// rollup(data, (v) => v["length"], (d) => (d["name"], d["date"]));
/// ```
///
/// This produces:
///
/// ```dart
/// {
///   ("jim", "11/12/2015"): 1,
///   ("carl", "11/12/2015"): 1,
///   ("stacy", "01/04/2016"): 2
/// };
/// ```
///
/// {@category Grouping data}
Map<K, R> rollup<T, R, K>(
    Iterable<T> iterable, R Function(List<T>) reduce, K Function(T) key) {
  var groups = <K, List<T>>{};
  for (var value in iterable) {
    (groups[key(value)] ??= []).add(value);
  }
  return groups.map((key, value) => MapEntry(key, reduce(value)));
}
