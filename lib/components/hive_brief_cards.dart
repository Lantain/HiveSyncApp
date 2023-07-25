import 'package:flutter/material.dart';

class HiveBriefCards extends StatelessWidget {
  final double? temperature;
  final double? humidity;
  final double? weight;

  const HiveBriefCards(
      {super.key,
      required this.temperature,
      required this.humidity,
      required this.weight});

  @override
  Widget build(BuildContext context) {
    final isHot = temperature != null ? temperature! >= 30 : false;
    final isCold = temperature != null ? temperature! <= 10 : false;

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 100,
        padding: const EdgeInsets.only(top: 32, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.thermostat,
                color: isHot
                    ? Colors.deepOrange.shade200
                    : (isCold ? Colors.blue.shade200 : Colors.black)),
            const Padding(padding: EdgeInsets.only(top: 4)),
            Text("${temperature?.toStringAsFixed(1) ?? 'Unknown '}°C")
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.only(top: 32, bottom: 16),
        width: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.water_drop_outlined),
            const Padding(padding: EdgeInsets.only(top: 4)),
            Text("${humidity?.toStringAsFixed(1) ?? 'Unknown '}%")
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.only(top: 32, bottom: 16),
        width: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.scale),
            const Padding(padding: EdgeInsets.only(top: 4)),
            Text("${weight?.toStringAsFixed(1) ?? 'Unknown'} kg")
          ],
        ),
      ),
    ]);
  }
}
