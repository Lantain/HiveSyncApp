import 'package:flutter/material.dart';
import 'package:hive_sync_app/components/hives_grid.dart';
import 'package:hive_sync_app/data/mock/hive.dart';
import 'package:hive_sync_app/views/add_hive.dart';
import 'package:hive_sync_app/views/hive.dart';

import '../data/model.dart';

Future<List<Hive>> fetchHives() async {
  await Future.delayed(const Duration(seconds: 1));

  return [
    generateHive("1"),
    generateHive("2"),
    generateHive("3"),
    generateHive("4"),
    generateHive("5"),
    generateHive("6"),
    generateHive("7"),
    generateHive("8"),
    generateHive("9"),
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ModalRoute.of(context)!.addScopedWillPopCallback(onRefresh);
    });
  }

  Future<bool> onRefresh() async {
    setState(() {
      futureHives = fetchHives();
    });
    await futureHives;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Hives"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
                  builder: (context) => const AddHivePage(),
                ))
                .then((value) => onRefresh());
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
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                              builder: (context) => HivePage(hiveId: hive.name),
                            ))
                            .then((value) => onRefresh());
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
