import 'dart:math';
import '../record.dart';

Record generateRecord() {
  final rng = Random();
  final r = Record();
  r.temperature = rng.nextDouble() * 60 - 20;
  r.humidity = rng.nextDouble() * 100;
  r.weight = rng.nextDouble() * 20;
  r.createdAt = DateTime.now()
      .subtract(Duration(minutes: rng.nextInt(20)))
      .millisecondsSinceEpoch;
  return r;
}
