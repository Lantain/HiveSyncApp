import 'dart:math';
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
      HiveRecord(rng.nextDouble() * 100, rng.nextDouble() * 100,
          rng.nextDouble() * 100));
}
