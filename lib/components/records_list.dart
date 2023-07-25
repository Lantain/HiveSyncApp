import 'package:flutter/material.dart';
import 'package:hive_sync_app/data/mock/record.dart';
import '../data/model.dart';

Future<List<Record>> fetchRecords(hiveId) async {
  await Future.delayed(const Duration(seconds: 2));
  return [
    generateRecord(),
    generateRecord(),
    generateRecord(),
    generateRecord(),
    generateRecord(),
    generateRecord(),
    generateRecord(),
    generateRecord(),
    generateRecord(),
  ];
}

class RecordsList extends StatefulWidget {
  final String hiveId;
  const RecordsList({super.key, required this.hiveId});

  @override
  State<StatefulWidget> createState() => _RecordsList();
}

class _RecordsList extends State<RecordsList> {
  late Future<List<Record>> futureRecords;
  Future onRefresh() async {
    futureRecords = fetchRecords(widget.hiveId);
    await futureRecords;
  }

  @override
  void initState() {
    super.initState();
    onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Record>>(
      future: futureRecords,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final records = snapshot.data!;
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
                              Text(
                                  "Humidity: ${record.humidity!.toStringAsFixed(1)}")
                          ]),
                    ));
              });
        }
        return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
