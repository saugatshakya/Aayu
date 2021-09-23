import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Doctors extends StatefulWidget {
  final List doctors;
  Doctors({required this.doctors});

  @override
  _DoctorsState createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  List doctors = [];
  getalldepartments() async {
    final response = await http.get(
      Uri.parse('https://call-db-aayu.herokuapp.com/api/doctor/list'),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      var serverResponse = response.body;
      doctors = jsonDecode(serverResponse);
      print(doctors);
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    getalldepartments();
    super.initState();
  }

  String status = Random().nextBool() ? "Available" : "Busy";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: GridView.count(
            crossAxisCount: 5,
            children: [
              for (int i = 0; i < widget.doctors.length; i++)
                Container(
                  color: widget.doctors[i]["status"] == "active"
                      ? Colors.lightBlue[200]
                      : Colors.red[200],
                  margin: const EdgeInsets.all(8.0),
                  child: GridTile(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(
                              child: Icon(Icons.person, color: Colors.white)),
                          Text(
                            widget.doctors[i]["doctor_name"] ?? "name",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            widget.doctors[i]["status"],
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            widget.doctors[i]["contact_phone"] ?? "contact",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
