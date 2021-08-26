import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Settings extends StatefulWidget {
  final int id;
  Settings({required this.id});

  @override
  _SettingsState createState() => _SettingsState(id: id);
}

class _SettingsState extends State<Settings> {
  final int id;
  late var hospital;
  _SettingsState({required this.id});
  gethospital() async {
    final response = await http.get(
      Uri.parse('https://call-db-aayu.herokuapp.com/api/hospital/$id'),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      var serverResponse = response.body;
      hospital = jsonDecode(serverResponse);
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    gethospital();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width - 16,
      height: MediaQuery.of(context).size.width - 16,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(4)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          hospital == null
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextField(
                      onChanged: (val) {
                        hospital = val;
                      },
                      onEditingComplete: () {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                          hintText: "Enter Hospital Name Here",
                          border: OutlineInputBorder())),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.lightBlue, Colors.white],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Text(
                      hospital["hospitalName"],
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                ),
          GestureDetector(
            onTap: () async {
              final response = await http.get(
                Uri.parse(
                    'https://call-db-aayu.herokuapp.com/api/hospital/$id'),
                headers: {
                  "Content-Type": "application/json",
                },
              );
              if (response.statusCode == 200) {
                var serverResponse = response.body;
                hospital = jsonDecode(serverResponse);
                setState(() {});
              } else {
                print(response.reasonPhrase);
              }
            },
            child: Container(
              color: Colors.blue,
              child: Text("Submit"),
            ),
          )
        ],
      ),
    );
  }
}
