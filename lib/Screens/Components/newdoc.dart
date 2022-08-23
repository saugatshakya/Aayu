import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class NewDoc extends StatefulWidget {
  @override
  _NewDocState createState() => _NewDocState();
}

class _NewDocState extends State<NewDoc> {
  bool expand = false;
  List departments = [];
  String name = "";
  String contact = "";
  Map department = {"department_name": "", "department_id": ""};

  getalldepartments() async {
    final response = await http.get(
      Uri.parse('https://call-db-aayu.herokuapp.com/api/department/list'),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      var serverResponse = response.body;
      departments = jsonDecode(serverResponse);
      print(departments);
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }

  registerDoctor(id) async {
    print("registering");
    final response = await http.post(
      Uri.parse('https://call-db-aayu.herokuapp.com/api/doctor/register/${id}'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"doctor_name": name, "contact_phone": contact}),
    );
    print(response.body);
    if (response.statusCode == 200) {
      var serverResponse = response.body;
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
    getalldepartments();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(16),
        width: 400,
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 400,
              child: TextField(
                onChanged: (val) {
                  name = val;
                  setState(() {});
                },
                decoration: InputDecoration(
                    hintText: "Enter Doctor Name",
                    border: OutlineInputBorder()),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              width: 400,
              child: TextField(
                onChanged: (val) {
                  contact = val;
                  setState(() {});
                },
                decoration: InputDecoration(
                    hintText: "Enter Contact", border: OutlineInputBorder()),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  expand = !expand;
                });
              },
              child: Container(
                  padding: EdgeInsets.all(8),
                  width: 400,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4)),
                  child: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Choose a Department"),
                          Icon(
                            Icons.arrow_downward_sharp,
                            color: Colors.grey,
                          ),
                        ]),
                    for (int i = 0; i < departments.length; i++)
                      expand
                          ? GestureDetector(
                              onTap: () {
                                department["department_name"] =
                                    departments[i]["department_name"];
                                department["department_id"] =
                                    departments[i]["department_id"];
                                expand = false;
                                setState(() {});
                              },
                              child: Text(departments[i]["department_name"]))
                          : Container()
                  ])),
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                registerDoctor(department["department_id"]);
              },
              child: Container(
                width: 400,
                color: Colors.grey,
                height: 40,
                child: Center(
                    child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
