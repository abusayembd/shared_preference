// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _textEditingController = TextEditingController();
  late SharedPreferences sp;

  String data = "No Data";

  @override
  Future<void> initState() async {
    // TODO: implement initState
    super.initState();
    sp = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _textEditingController,
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  bool isSaved = await sp.setString(
                      "greetings", _textEditingController.text);
                  if (isSaved) {
                    print("Saved Successfully");
                  } else {
                    print("Failed to save Data ");
                  }
                },
                child: const Text("Save")),
            ElevatedButton(
                onPressed: () async {
                  String? spData = sp.getString("greetings");
                  setState(() {
                    data = spData ?? "Failed";
                  });
                },
                child: const Text("Show")),
            Text(
              data,
              style: const TextStyle(fontSize: 44.0),
            ),
          ],
        )),
      ),
    );
  }
}
