import 'dart:convert';

import 'package:aayu/Screens/auth/authenticate.dart';
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
  var hospital;
  bool pats = true;
  bool doctors = true;

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
      print(hospital);
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
                    child: Text(
                      hospital["hospital_name"],
                      style: TextStyle(fontSize: 32, color: Colors.lightBlue),
                    ),
                  ),
                ),
          // GestureDetector(
          //   onTap: () async {
          //     final response = await http.get(
          //       Uri.parse(
          //           'https://call-db-aayu.herokuapp.com/api/hospital/$id'),
          //       headers: {
          //         "Content-Type": "application/json",
          //       },
          //     );
          //     if (response.statusCode == 200) {
          //       var serverResponse = response.body;
          //       hospital = jsonDecode(serverResponse);
          //       setState(() {});
          //     } else {
          //       print(response.reasonPhrase);
          //     }
          //   },
          //   child: Container(
          //     color: Colors.blue,
          //     child: Text("Submit"),
          //   ),
          // )
          SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Allow Patients",
                  style: TextStyle(color: Colors.lightBlue),
                ),
                SizedBox(
                  width: 200,
                ),
                Checkbox(
                    value: pats,
                    onChanged: (val) {
                      setState(() {
                        pats = val!;
                      });
                    })
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Allow Doctors",
                  style: TextStyle(color: Colors.lightBlue),
                ),
                SizedBox(
                  width: 200,
                ),
                Checkbox(
                    value: doctors,
                    onChanged: (val) {
                      setState(() {
                        doctors = val!;
                      });
                    })
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext context) => Auth()));
            },
            child: Container(
              padding: EdgeInsets.all(12),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.lightBlue)),
              child: Center(child: Text("SignOut")),
            ),
          )
        ],
      ),
    );
  }
}
