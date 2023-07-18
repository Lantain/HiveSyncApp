import 'package:flutter/material.dart';

class AddHivePage extends StatefulWidget {
  const AddHivePage({super.key});

  @override
  State<AddHivePage> createState() => _AddHivePage();
}

class _AddHivePage extends State<AddHivePage> {
  bool isLoading = false;

  onSubmit() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Added a hive!")));
      await Future.delayed(const Duration(milliseconds: 300));
      Navigator.of(context).pop();
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
