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
    final isHot = rec.temperature! >= 30;
    final isCold = rec.temperature! <= 10;

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 100,
        padding: EdgeInsets.only(top: 32, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.thermostat),
            Padding(padding: EdgeInsets.only(top: 4)),
            Text("${rec.temperature?.toStringAsFixed(1)}°C")
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 32, bottom: 16),
        width: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.water_drop_outlined),
            Padding(padding: EdgeInsets.only(top: 4)),
            Text("${rec.humidity?.toStringAsFixed(1)}%")
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 32, bottom: 16),
        width: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.scale),
            Padding(padding: EdgeInsets.only(top: 4)),
            Text("0 kg")
          ],
        ),
      ),
    ]);
    // Card(
    //   color: isHot
    //       ? Colors.deepOrange.shade200
    //       : (isCold ? Colors.blue.shade200 : Colors.orange.shade100),
    //   child: Container(
    //       padding:
    //           const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    //       width: 120,
    //       height: 160,
    //       child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             const Text(
    //               "Temperature:",
    //               style: TextStyle(fontWeight: FontWeight.bold),
    //             ),
    //             Text("${rec.temperature?.toStringAsFixed(1)}C")
    //           ])),
    // ),
    // Card(
    //   color: Colors.blue.shade50,
    //   child: Container(
    //       padding:
    //           const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    //       width: 120,
    //       height: 160,
    //       child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             const Text(
    //               "Humidity:",
    //               style: TextStyle(fontWeight: FontWeight.bold),
    //             ),
    //             Text("${rec.humidity?.toStringAsFixed(1)}%")
    //           ])),
    // ),
    // Card(
    //   child: Container(
    //       padding:
    //           const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    //       width: 120,
    //       height: 160,
    //       child: const Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               "Weight:",
    //               style: TextStyle(fontWeight: FontWeight.bold),
    //             ),
    //             Text("Unknown kilos")
    //           ])),
    // )
  }
}
