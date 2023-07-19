import 'package:flutter/material.dart';

import '../data/model.dart';

class HiveBriefCards extends StatelessWidget {
  final Hive hive;
  const HiveBriefCards({super.key, required this.hive});

  Record scanLastRecords(Hive hive) {
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
    final rec = scanLastRecords(hive);
    return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Card(
                child: Container(
                    padding: const EdgeInsets.all(4),
                    width: 120,
                    height: 160,
                    child: Column(children: [
                      const Text(
                        "Temperature:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("${rec.temperature?.toStringAsFixed(1)}C")
                    ])),
              ),
              Card(
                child: Container(
                    padding: const EdgeInsets.all(4),
                    width: 120,
                    height: 160,
                    child: Column(children: [
                      const Text(
                        "Humidity:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("${rec.humidity?.toStringAsFixed(1)}%")
                    ])),
              )
            ],
          ),
        ));
  }
}
