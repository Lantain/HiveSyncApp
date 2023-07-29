import 'dart:math';
import '../hive.dart';
import '../model.dart';

Hive generateHive(id) {
  final rng = Random();
  int hid = rng.nextInt(30);

  final h = Hive();
  final b = HiveBrief();
  b.temperature = rng.nextDouble() * 100;
  b.humidity = rng.nextDouble() * 100;
  b.weight = rng.nextDouble() * 100;

  h.id = "$id $hid";
  h.name = "Hive $hid";
  h.lastSeenAt = DateTime.now()
      .subtract(Duration(minutes: rng.nextInt(20)))
      .millisecondsSinceEpoch;
  h.brief = b;
  return h;
}
