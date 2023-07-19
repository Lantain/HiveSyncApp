import 'dart:math';
import '../model.dart';

Record generateRecord() {
  final rng = Random();
  return Record(10, rng.nextDouble() * 100, null);
}
