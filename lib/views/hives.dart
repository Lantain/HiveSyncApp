import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_sync_app/components/hives_grid.dart';
import 'package:hive_sync_app/data/mock/hive.dart';
import 'package:hive_sync_app/views/add_hive.dart';
import 'package:hive_sync_app/views/hive.dart';
import 'package:hive_sync_app/views/login.dart';

import '../data/api_client.dart';
import '../data/auth.dart';
import '../data/hive.dart';
import '../data/model.dart';

class HivesPage extends StatefulWidget {
  const HivesPage({super.key});

  @override
  State<StatefulWidget> createState() => _HivesPage();
}

class _HivesPage extends State<HivesPage> {
  // final hives = hivesMock;
  late Future<List<Hive>> futureHives;
  ApiClient? api;
  Auth auth = Auth();

  Future<List<Hive>> fetchHives() async {
    final hives = await api?.getHives();
    return hives ?? [];
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ModalRoute.of(context)!.addScopedWillPopCallback(onRefresh);
    });
    initAsync();
  }

  Future<void> initAsync() async {
    if (auth.currentUser != null) {
      final a = await ApiClient.getInstance();
      setState(() {
        api = a;
        futureHives = fetchHives();
      });
    }
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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: IconButton(
                  onPressed: () async {
                    await api?.logout();
                    Navigator.of(context, rootNavigator: true)
                        .pushReplacement(MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
                  },
                  icon: const Icon(Icons.logout)),
            ),
            if (auth.currentUser?.photoURL != null)
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: CircleAvatar(
                  backgroundImage:
                      NetworkImage(auth.currentUser?.photoURL ?? ""),
                ),
              )
          ],
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
          child: api != null
              ? FutureBuilder<List<Hive>>(
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
                                    builder: (context) =>
                                        HivePage(hiveId: hive.id!),
                                  ))
                                  .then((value) => onRefresh());
                            },
                          ));
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                )
              : const CircularProgressIndicator(),
        ));
  }
}
