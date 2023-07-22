import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_sync_app/components/hive_brief_cards.dart';
import 'package:hive_sync_app/components/records_list.dart';
import 'package:hive_sync_app/data/mock/hive.dart';
import 'package:hive_sync_app/data/model.dart';

Future<Hive> fetchHive(hiveId) async {
  await Future.delayed(const Duration(seconds: 1));
  return generateHive("sample");
}

class RecordsHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final double height;

  RecordsHeaderDelegate(this.title, [this.height = 50]);

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: Colors.orange.shade50,
        padding: const EdgeInsets.only(top: 12),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16))),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: const Center(child: Text("Records")),
        ));
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}

class HivePage extends StatefulHookWidget {
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
    onRefresh();
  }

  Future onRefresh() async {
    futureHive = fetchHive(widget.hiveId);
    await futureHive;
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final isCollapsed = useState(false);

    return Scaffold(
      body: Container(
        color: Colors.orange.shade100,
        child: FutureBuilder<Hive>(
          future: futureHive,
          builder: (context, snapshot) {
            const collapsedBarHeight = 56.0;
            const expandedBarHeight = 264.0;
            const diff = (expandedBarHeight - collapsedBarHeight);
            if (snapshot.hasData) {
              final lsa = DateTime.fromMillisecondsSinceEpoch(
                  snapshot.data!.lastSeenAt);

              Future.delayed(Duration.zero, () {
                setState(() {
                  hiveName = snapshot.data?.name;
                });
              });
              return RefreshIndicator(
                  onRefresh: onRefresh,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      isCollapsed.value = scrollController.hasClients &&
                          scrollController.offset > diff;
                      return false;
                    },
                    child: CustomScrollView(
                      controller: scrollController,
                      slivers: [
                        SliverAppBar(
                          title: AnimatedOpacity(
                            duration: const Duration(milliseconds: 100),
                            opacity: isCollapsed.value ? 1 : 0,
                            child: Text(snapshot.data!.name),
                          ),
                          floating: true,
                          pinned: true,
                          expandedHeight: expandedBarHeight,
                          collapsedHeight: collapsedBarHeight,
                          backgroundColor: isCollapsed.value
                              ? Colors.orange.shade200
                              : Colors.orange.shade100,
                          stretchTriggerOffset: 100,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Container(
                                padding: const EdgeInsets.only(top: 82),
                                color: Colors.orange.shade50,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 16),
                                              child: AnimatedOpacity(
                                                  opacity:
                                                      isCollapsed.value ? 0 : 1,
                                                  duration: const Duration(
                                                      milliseconds: 100),
                                                  child: Text(
                                                      snapshot.data!.name,
                                                      style: const TextStyle(
                                                          fontSize: 32)))),
                                          Text(snapshot.data!.id),
                                          Text("Last Seen at $lsa"),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        width: double.infinity,
                                        child: HiveBriefCards(
                                            hive: snapshot.data!))
                                  ],
                                )),
                          ),
                        ),
                        SliverPersistentHeader(
                          delegate: RecordsHeaderDelegate("Records"),
                          pinned: true,
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(8),
                          sliver: RecordsList(records: snapshot.data!.records),
                        )
                      ],
                    ),
                  ));
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
