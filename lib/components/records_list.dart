import 'package:flutter/material.dart';
import 'package:hive_sync_app/data/mock/record.dart';
import '../data/api_client.dart';
import '../data/model.dart';
import '../data/record.dart';

class RecordsList extends StatefulWidget {
  final String hiveId;
  final ScrollController scrollController;
  const RecordsList(
      {super.key, required this.hiveId, required this.scrollController});

  @override
  State<StatefulWidget> createState() => _RecordsList();
}

class _RecordsList extends State<RecordsList> {
  late Future<List<Record>> futureRecords;
  late List<Record> recordsData = [];
  int page = 1;
  int limit = 20;
  bool isInfiniteLoading = false;

  Future<List<Record>> fetchRecords(hiveId, page, offset) async {
    final api = await ApiClient.getInstance();
    final records = await api.getRecords(hiveId, page, offset);
    return records;
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future onRefresh() async {
    futureRecords = fetchRecords(widget.hiveId, limit, (page - 1) * limit);

    final recs = await futureRecords;

    setState(() {
      recordsData.addAll(recs);
    });
  }

  onMoreRecords() async {
    if (!isInfiniteLoading) {
      print("Loading $page");
      setState(() {
        isInfiniteLoading = true;
        page = page + 1;
      });
      await onRefresh();
      Future.delayed(Duration.zero, () {
        setState(() {
          isInfiniteLoading = false;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    widget.scrollController.addListener(() {
      if (widget.scrollController.position.maxScrollExtent ==
          widget.scrollController.offset) {
        onMoreRecords();
      }
    });
    return FutureBuilder<List<Record>>(
      future: futureRecords,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SliverList.builder(
              itemCount: recordsData.length + 1,
              itemBuilder: (context, index) {
                if (index < recordsData.length) {
                  final record = recordsData[index];
                  final lsa =
                      DateTime.fromMillisecondsSinceEpoch(record.createdAt!);
                  return Card(
                      color: Colors.orange.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${lsa ?? 'Unknown'}"),
                              if (record.temperature != null)
                                Text(
                                    "Temperature: ${record.temperature!.toStringAsFixed(1)}"),
                              if (record.humidity != null)
                                Text(
                                    "Humidity: ${record.humidity!.toStringAsFixed(1)}")
                            ]),
                      ));
                } else {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              });
        }
        return SliverToBoxAdapter(
            child: Center(
                child: Container(
                    padding: const EdgeInsets.only(top: 16),
                    child: const CircularProgressIndicator())));
      },
    );
  }
}
