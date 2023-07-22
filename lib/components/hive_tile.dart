import 'package:flutter/material.dart';

import '../data/model.dart';

class HiveTile extends StatelessWidget {
  final Hive hive;
  final Function onTap;
  const HiveTile({super.key, required this.hive, required this.onTap});

  Record scanLastRecords() {
    final record = Record(null, null, null);
    for (var i = 0; i < hive.records.length; i++) {
      var rec = hive.records[i];
      record.temperature = record.temperature ?? rec.temperature;
      record.humidity = record.humidity ?? rec.humidity;
    }
    return record;
  }

  @override
  Widget build(BuildContext context) {
    final record = scanLastRecords();
    var lastSeenDate = DateTime.fromMillisecondsSinceEpoch(hive.lastSeenAt);
    Duration diff = DateTime.now().difference(lastSeenDate);
    final bool isOnline = diff.inMinutes < 10;
    const int kilos = 0;
    return Card(
        child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            onTap: () => onTap(),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(hive.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    isOnline
                        ? const Text(
                            style: TextStyle(color: Colors.greenAccent),
                            "online")
                        : const Text(
                            style: TextStyle(color: Colors.redAccent),
                            "offline"),
                    Text("Temp: ${record.temperature?.toStringAsFixed(1)}C"),
                    Text("Hum: ${record.humidity?.toStringAsFixed(1)}%"),
                    const Text("$kilos kg"),
                    const Spacer(),
                  ]),
            )));
  }
}
