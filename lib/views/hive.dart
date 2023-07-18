import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_sync_app/data/model.dart';

Future<Hive> fetchHive(hiveId) async {
  await Future.delayed(const Duration(seconds: 1));
  final rng = Random();
  return Hive(
      "ID: $hiveId",
      DateTime.now()
          .subtract(const Duration(minutes: 11))
          .millisecondsSinceEpoch,
      [Record(10, rng.nextDouble() * 100, null), Record(20, null, null)]);
}

class HivePage extends StatefulWidget {
  final String hiveId;
  const HivePage({super.key, required this.hiveId});

  @override
  State<StatefulWidget> createState() => _HivePage();
}

class _HivePage extends State<HivePage> {
  late Future<Hive> futureHive;

  @override
  void initState() {
    super.initState();
    futureHive = fetchHive(widget.hiveId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Le HIVE"),
        ),
        body: Center(
          child: FutureBuilder<Hive>(
            future: futureHive,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text('HIVE: ${snapshot.data?.name}');
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ));
  }
}
