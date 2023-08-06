num zeroIfNull(num? x) {
  return x ?? 0;
}

num nanIfNull(num? x) {
  return x ?? double.nan;
}

List<num> numbers(Iterable<num?> values) {
  var numbers = <num>[];
  for (var value in values) {
    if (value != null && !value.isNaN) {
      numbers.add(value);
    }
  }
  return numbers;
}

List<num> numbersBy<T>(Iterable<T> values, num? Function(T) accessor) {
  var numbers = <num>[];
  for (var value in values) {
    var result = accessor(value);
    if (result != null && !result.isNaN) {
      numbers.add(result);
    }
  }
  return numbers;
}

int toInt32(num x) => x.truncate() & 0xFFFFFFFF;
