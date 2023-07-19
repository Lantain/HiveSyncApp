import 'package:flutter/material.dart';
import '../data/model.dart';

class RecordsList extends StatelessWidget {
  final List<Record> records;
  const RecordsList({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: records.length,
        itemBuilder: (BuildContext context, int index) {
          final record = records[index];
          return Card(
              child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(children: [Text("${record.createdAt ?? 'Unknown'}")]),
          ));
        });
  }
}
