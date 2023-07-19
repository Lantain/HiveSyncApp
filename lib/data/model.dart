class Record {
  late double? temperature;
  late double? humidity;
  late String? payload;
  int? createdAt;
  Record(this.temperature, this.humidity, this.payload);
}

class Hive {
  late String id;
  late String name;
  late int lastSeenAt;
  late List<Record> records;
  Hive(this.id, this.name, this.lastSeenAt, this.records);
}
