class Record {
  late double? temperature;
  late double? humidity;
  late String? payload;
  Record(this.temperature, this.humidity, this.payload);
}

class Hive {
  late String name;
  late int lastSeenAt;
  late List<Record> records;
  Hive(this.name, this.lastSeenAt, this.records);
}
