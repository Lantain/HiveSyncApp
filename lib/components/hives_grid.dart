import 'package:flutter/material.dart';
import 'package:hive_sync_app/components/hive_tile.dart';

import '../data/hive.dart';
import '../data/model.dart';

class HivesList extends StatelessWidget {
  final List<Hive> hives;
  final Function onSelect;
  const HivesList({super.key, required this.hives, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    if (hives.isEmpty) {
      return const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("You have no hives =("), Text("But you can add one!")],
      );
    }
    return Container(
        padding: const EdgeInsets.all(8),
        child: GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: List.generate(
                hives.length,
                (index) => HiveTile(
                    onTap: () => onSelect(hives[index]), hive: hives[index]))));
  }
}
