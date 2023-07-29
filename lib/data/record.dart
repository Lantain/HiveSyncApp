class Record {
  double? temperature;
  double? humidity;
  double? weight;
  String? payload;
  int? createdAt;

  static Record fromServerResponse(res) {
    final r = Record();
    r.createdAt = res['createdAt'];
    r.humidity = res['humidity'] + 0.0;
    r.temperature = res['temperature'] + 0.0;
    r.weight = (res['weight'] ?? 0) + 0.0;
    r.payload = res['payload'];
    return r;
  }
}
