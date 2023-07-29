class HiveBrief {
  double? temperature;
  double? humidity;
  double? weight;

  static fromServerResponse(res) {
    if (res == null) return null;

    final b = HiveBrief();
    b.humidity = res['humidity'];
    b.temperature = res['temperature'];
    b.weight = res['weight'];
    return b;
  }
}

class Hive {
  String? id;
  String? name;
  int? lastSeenAt;
  HiveBrief? brief;
  Hive();

  static Hive fromServerResponse(res) {
    final h = Hive();
    h.id = res['id'];
    h.lastSeenAt = res['lastSeenAt'];
    h.name = res['name'];
    h.brief = HiveBrief.fromServerResponse(res['rec']);

    return h;
  }
}
