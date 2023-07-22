import 'dart:math';

import 'package:hive_sync_app/data/mock/record.dart';

import '../model.dart';

Hive generateHive(id) {
  final rng = Random();
  int hid = rng.nextInt(30);
  return Hive(
      "$id $hid",
      "Hive $hid",
      DateTime.now()
          .subtract(Duration(minutes: rng.nextInt(20)))
          .millisecondsSinceEpoch,
      [
        generateRecord(),
        generateRecord(),
        generateRecord(),
        generateRecord(),
        generateRecord(),
        generateRecord(),
        generateRecord(),
        generateRecord(),
        generateRecord(),
        generateRecord(),
        generateRecord(),
        generateRecord(),
        generateRecord(),
      ]);
}
