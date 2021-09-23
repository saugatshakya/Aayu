import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Department extends StatefulWidget {
  final List departments;
  Department({required this.departments});

  @override
  _DepartmentState createState() => _DepartmentState();
}

class _DepartmentState extends State<Department> {
  List departments = [];
  deletedepartment(id) async {
    final response = await http.get(
      Uri.parse('https://call-db-aayu.herokuapp.com/api/department/delete/id'),
      headers: {
        "Content-Type": "application/json",
      },
    );
    print("hey");
    if (response.statusCode == 200) {
      var serverResponse = response.body;
      print(serverResponse);
      getalldepartments();
    } else {
      print(response.reasonPhrase);
    }
  }

  getalldepartments() async {
    print("hello");
    final response = await http.get(
      Uri.parse('https://call-db-aayu.herokuapp.com/api/department/list'),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      var serverResponse = response.body;
      departments = jsonDecode(serverResponse);
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < widget.departments.length; i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: ListTile(
                    tileColor: Colors.lightBlue,
                    dense: true,
                    title: Row(children: [
                      Text(widget.departments[i]["id"].toString(),
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 12,
                      ),
                      Text(widget.departments[i]["name"] ?? "department",
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 100,
                      ),
                      Text(
                          "Available Beds: " +
                              widget.departments[i]["aBeds"].toString(),
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                          "Occupied Beds: " +
                              widget.departments[i]["oBeds"].toString(),
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ]),
                    trailing: GestureDetector(
                        onTap: () async {
                          final response = await http.get(
                            Uri.parse(
                                'https://call-db-aayu.herokuapp.com/api/department/delete/${departments[i]["department_id"]}'),
                            headers: {
                              "Content-Type": "application/json",
                            },
                          );
                          print("hey");
                          if (response.statusCode == 200) {
                            var serverResponse = response.body;
                            print(serverResponse);
                            getalldepartments();
                          } else {
                            print(response.reasonPhrase);
                          }
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        )),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
