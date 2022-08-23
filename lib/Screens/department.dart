import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Department extends StatefulWidget {
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
    if (response.statusCode == 200) {
      getalldepartments();
    } else {
      print(response.reasonPhrase);
    }
  }

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
            for (int i = 0; i < departments.length; i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: ListTile(
                    tileColor: Colors.lightBlue,
                    dense: true,
                    title: Row(children: [
                      Text(departments[i]["department_id"].toString(),
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 12,
                      ),
                      Text(departments[i]["department_name"] ?? "department",
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 100,
                      ),
                      Text(
                          "Available Beds: " +
                              departments[i]["available_bed"].toString(),
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                          "Occupied Beds: " +
                              departments[i]["occupied_bed"].toString(),
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
                          if (response.statusCode == 200) {
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
