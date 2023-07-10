import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String _name = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Your name',
                border: OutlineInputBorder(),
              ),
            ),
            TextButton(
                onPressed: () async {
                  final response = await http.post(
                      Uri.parse("http://192.168.1.37:8000/api/welcome"),
                      body: {
                        "name": _name,
                      });
                  var jsonBody = jsonDecode(response.body);
                  Fluttertoast.showToast(msg: jsonBody['message']);
                },
                child: const Text('Send'))
          ],
        )),
      ),
    );
  }
}
