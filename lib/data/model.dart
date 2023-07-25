class Record {
  late double? temperature;
  late double? humidity;
  late String? payload;
  int? createdAt;
  Record(this.temperature, this.humidity, this.payload);
}

class HiveRecord {
  double? temperature;
  double? humidity;
  double? weight;

  HiveRecord(this.temperature, this.humidity, this.weight);
}

class Hive {
  late String id;
  late String name;
  late int lastSeenAt;
  late HiveRecord rec;

  Hive(this.id, this.name, this.lastSeenAt, this.rec);
}
