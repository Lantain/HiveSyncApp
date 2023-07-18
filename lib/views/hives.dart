import 'package:flutter/material.dart';
import 'package:hive_sync_app/components/hives_grid.dart';
import 'package:hive_sync_app/views/add_hive.dart';
import 'package:hive_sync_app/views/hive.dart';
import 'dart:math';

import '../data/model.dart';

Future<List<Hive>> fetchHives() async {
  await Future.delayed(const Duration(seconds: 1));
  final rng = Random();

  return [
    Hive(
        "Hive 1",
        DateTime.now()
            .subtract(const Duration(minutes: 11))
            .millisecondsSinceEpoch,
        [Record(10, rng.nextDouble() * 100, null), Record(20, null, null)]),
    Hive(
        "Hive 2",
        DateTime.now()
            .subtract(const Duration(minutes: 3))
            .millisecondsSinceEpoch,
        [Record(11, rng.nextDouble() * 100, null), Record(21, null, null)]),
    Hive(
        "Hive 3",
        DateTime.now()
            .subtract(const Duration(minutes: 6))
            .millisecondsSinceEpoch,
        [Record(12, 12, null), Record(22, null, null)]),
    Hive(
        "Hive 4",
        DateTime.now()
            .subtract(const Duration(minutes: 10))
            .millisecondsSinceEpoch,
        [Record(10, 10, null), Record(20, null, null)]),
    Hive(
        "Hive 5",
        DateTime.now()
            .subtract(const Duration(minutes: 3))
            .millisecondsSinceEpoch,
        [Record(11, 11, null), Record(21, null, null)]),
    Hive(
        "Hive 6",
        DateTime.now()
            .subtract(const Duration(minutes: 6))
            .millisecondsSinceEpoch,
        [Record(12, 12, null), Record(22, null, null)]),
    Hive(
        "Hive 7",
        DateTime.now()
            .subtract(const Duration(minutes: 10))
            .millisecondsSinceEpoch,
        [Record(10, 10, null), Record(20, null, null)]),
    Hive(
        "Hive 8",
        DateTime.now()
            .subtract(const Duration(minutes: 3))
            .millisecondsSinceEpoch,
        [Record(11, 11, null), Record(21, null, null)]),
    Hive(
        "Hive 9",
        DateTime.now()
            .subtract(const Duration(minutes: 6))
            .millisecondsSinceEpoch,
        [Record(12, 12, null), Record(22, null, null)])
  ];
}

class HivesPage extends StatefulWidget {
  const HivesPage({super.key});

  @override
  State<StatefulWidget> createState() => _HivesPage();
}

class _HivesPage extends State<HivesPage> {
  // final hives = hivesMock;
  late Future<List<Hive>> futureHives;

  @override
  void initState() {
    super.initState();
    futureHives = fetchHives();
  }

  Future onRefresh() async {
    setState(() {
      futureHives = fetchHives();
    });
    await futureHives;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Le HIVES"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddHivePage(),
            ));
          },
          child: const Icon(Icons.add),
        ),
        body: Center(
          child: FutureBuilder<List<Hive>>(
            future: futureHives,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return RefreshIndicator(
                    onRefresh: onRefresh,
                    child: HivesList(
                      hives: snapshot.data!,
                      onSelect: (Hive hive) {
                        print("whoop ${hive.name}");
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HivePage(hiveId: hive.name),
                        ));
                      },
                    ));
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ));
  }
}
