import 'package:flutter/material.dart';
import '../data/model.dart';

class RecordsList extends StatelessWidget {
  final List<Record> records;
  const RecordsList({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemCount: records.length,
        itemBuilder: (context, index) {
          final record = records[index];
          return Card(
              color: Colors.orange.shade50,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${record.createdAt ?? 'Unknown'}"),
                      if (record.temperature != null)
                        Text(
                            "Temperature: ${record.temperature!.toStringAsFixed(1)}"),
                      if (record.humidity != null)
                        Text("Humidity: ${record.humidity!.toStringAsFixed(1)}")
                    ]),
              ));
        });
  }
}
