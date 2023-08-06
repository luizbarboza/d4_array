import 'dart:math';

import 'package:d4_array/d4_array.dart';
import 'package:d4_array/src/number.dart';
import 'package:test/test.dart';

void main() {
  test("shuffle(array) shuffles the array in-place", () {
    final numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
    final shuffle = shuffler(randomLcg(0.9051667019185816));
    expect(shuffle(numbers), numbers);
    assert(pairs(numbers).any((x) => x.$1 > x.$2)); // shuffled
  });

  test("shuffler(random)(array) shuffles the array in-place", () {
    final numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
    final shuffle = shuffler(randomLcg(0.9051667019185816));
    expect(shuffle(numbers), numbers);
    expect(numbers, [7, 4, 5, 3, 9, 0, 6, 1, 2, 8]);
  });

  test(
      "shuffler(random)(array, start) shuffles the subset array[start:] in-place",
      () {
    final numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
    final shuffle = shuffler(randomLcg(0.9051667019185816));
    expect(shuffle(numbers, 4), numbers);
    expect(numbers, [0, 1, 2, 3, 8, 7, 6, 4, 5, 9]);
  });

  test(
      "shuffler(random)(array, start, end) shuffles the subset array[start:end] in-place",
      () {
    final numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
    final shuffle = shuffler(randomLcg(0.9051667019185816));
    expect(shuffle(numbers, 3, 8), numbers);
    expect(numbers, [0, 1, 2, 5, 6, 3, 4, 7, 8, 9]);
  });
}

const mul = 0x19660D;
const inc = 0x3C6EF35F;
const eps = 1 / 0x100000000;

num Function() randomLcg([num? seed]) {
  seed ??= Random().nextInt(1);
  var state = toInt32(0 <= seed && seed < 1 ? seed / eps : seed.abs());
  return () {
    state = toInt32(mul * state + inc);
    return eps * (state >>> 0);
  };
}
