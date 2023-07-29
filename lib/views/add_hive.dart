import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_sync_app/data/api_client.dart';

class AddHivePage extends StatefulWidget {
  const AddHivePage({super.key});

  @override
  State<AddHivePage> createState() => _AddHivePage();
}

class _AddHivePage extends State<AddHivePage> {
  bool isLoading = false;
  String _name = "";

  void _updateName(val) {
    setState(() {
      _name = val;
    });
  }

  onSubmit() async {
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      final client = await ApiClient.getInstance();
      await client.addHiveToUser(_name);
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Added a hive!")));
        await Future.delayed(const Duration(milliseconds: 300));
        Navigator.of(context).pop();
      }
    } on DioException catch (e) {
      if (context.mounted) {
        if (e.response?.statusCode == 404) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Hive is not found")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Failed to add a hive")));
        }
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a hive'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  onChanged: _updateName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Hive ID',
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: ElevatedButton(
                        onPressed: onSubmit,
                        child: isLoading
                            ? Container(
                                width: 24,
                                height: 24,
                                padding: const EdgeInsets.all(2.0),
                                child: const CircularProgressIndicator(
                                  strokeWidth: 3,
                                ),
                              )
                            : const Text("Add Hive")))
              ]),
        ),
      ),
    );
  }
}
