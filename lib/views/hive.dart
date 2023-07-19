import 'package:flutter/material.dart';
import 'package:hive_sync_app/components/hive_brief_cards.dart';
import 'package:hive_sync_app/components/records_list.dart';
import 'package:hive_sync_app/data/mock/hive.dart';
import 'package:hive_sync_app/data/model.dart';

Future<Hive> fetchHive(hiveId) async {
  await Future.delayed(const Duration(seconds: 1));
  return generateHive("sample");
}

class HivePage extends StatefulWidget {
  final String hiveId;
  const HivePage({super.key, required this.hiveId});

  @override
  State<StatefulWidget> createState() => _HivePage();
}

class _HivePage extends State<HivePage> {
  late Future<Hive> futureHive;
  String? hiveName;

  @override
  void initState() {
    super.initState();
    futureHive = fetchHive(widget.hiveId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            hiveName != null ? Text(hiveName!) : const Text("Loading hive..."),
      ),
      body: FutureBuilder<Hive>(
        future: futureHive,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final lsa =
                DateTime.fromMillisecondsSinceEpoch(snapshot.data!.lastSeenAt);

            Future.delayed(Duration.zero, () {
              setState(() {
                hiveName = snapshot.data?.name;
              });
            });

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snapshot.data!.id),
                      Text("Last Seen at $lsa"),
                    ],
                  ),
                ),
                HiveBriefCards(hive: snapshot.data!),
                RecordsList(records: snapshot.data!.records)
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
