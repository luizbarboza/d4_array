import 'dart:convert';
import 'dart:io';

import 'package:d4_array/d4_array.dart';
import 'package:test/test.dart';

void main() {
  final barley = jsonDecode(File("./test/data/barley.json").readAsStringSync());

  test(
      "rollupSort(data, reduce, key) returns sorted keys when reduce is an accessor",
      () {
    expect(
        rollupSort<dynamic, num?, String>(
            barley, (g) => medianBy(g, (d) => d["yield"]), (d) => d["variety"]),
        [
          "Svansota",
          "No. 462",
          "Manchuria",
          "No. 475",
          "Velvet",
          "Peatland",
          "Glabron",
          "No. 457",
          "Wisconsin No. 38",
          "Trebi"
        ]);
    expect(
        rollupSort<dynamic, num?, String>(barley,
            (g) => -medianBy(g, (d) => d["yield"])!, (d) => d["variety"]),
        [
          "Trebi",
          "Wisconsin No. 38",
          "No. 457",
          "Glabron",
          "Peatland",
          "Velvet",
          "No. 475",
          "Manchuria",
          "No. 462",
          "Svansota"
        ]);
    expect(
        rollupSort<dynamic, num?, String>(barley,
            (g) => medianBy(g, (d) => -d["yield"]), (d) => d["variety"]),
        [
          "Trebi",
          "Wisconsin No. 38",
          "No. 457",
          "Glabron",
          "Peatland",
          "Velvet",
          "No. 475",
          "Manchuria",
          "No. 462",
          "Svansota"
        ]);
    expect(
        rollupSort<dynamic, num?, String>(
            barley, (g) => medianBy(g, (d) => d["yield"]), (d) => d["site"]),
        [
          "Grand Rapids",
          "Duluth",
          "University Farm",
          "Morris",
          "Crookston",
          "Waseca"
        ]);
    expect(
        rollupSort<dynamic, num?, String>(
            barley, (g) => -medianBy(g, (d) => d["yield"])!, (d) => d["site"]),
        [
          "Waseca",
          "Crookston",
          "Morris",
          "University Farm",
          "Duluth",
          "Grand Rapids"
        ]);
    expect(
        rollupSort<dynamic, num?, String>(
            barley, (g) => medianBy(g, (d) => -d["yield"]), (d) => d["site"]),
        [
          "Waseca",
          "Crookston",
          "Morris",
          "University Farm",
          "Duluth",
          "Grand Rapids"
        ]);
  });

  test(
      "groupSort(data, reduce, key) returns sorted keys when reduce is a comparator",
      () {
    expect(
        groupSort<dynamic, String>(
            barley,
            (d) => d["variety"],
            (a, b) => ascending(medianBy(a, (d) => d["yield"]),
                medianBy(b, (d) => d["yield"]))),
        [
          "Svansota",
          "No. 462",
          "Manchuria",
          "No. 475",
          "Velvet",
          "Peatland",
          "Glabron",
          "No. 457",
          "Wisconsin No. 38",
          "Trebi"
        ]);
    expect(
        groupSort<dynamic, String>(
            barley,
            (d) => d["variety"],
            (a, b) => descending(medianBy(a, (d) => d["yield"]),
                medianBy(b, (d) => d["yield"]))),
        [
          "Trebi",
          "Wisconsin No. 38",
          "No. 457",
          "Glabron",
          "Peatland",
          "Velvet",
          "No. 475",
          "Manchuria",
          "No. 462",
          "Svansota"
        ]);
    expect(
        groupSort<dynamic, String>(
            barley,
            (d) => d["site"],
            (a, b) => ascending(medianBy(a, (d) => d["yield"]),
                medianBy(b, (d) => d["yield"]))),
        [
          "Grand Rapids",
          "Duluth",
          "University Farm",
          "Morris",
          "Crookston",
          "Waseca"
        ]);
    expect(
        groupSort<dynamic, String>(
            barley,
            (d) => d["site"],
            (a, b) => descending(medianBy(a, (d) => d["yield"]),
                medianBy(b, (d) => d["yield"]))),
        [
          "Waseca",
          "Crookston",
          "Morris",
          "University Farm",
          "Duluth",
          "Grand Rapids"
        ]);
  });
}
