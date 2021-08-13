import 'dart:async';
import 'dart:convert';

import 'package:aayu/Screens/cases.dart';
import 'package:aayu/Screens/department.dart';
import 'package:aayu/Screens/doctors.dart';
import 'package:aayu/Screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  final int id;
  final initpage;
  Home({
    required this.id,
    required this.initpage,
  });
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List menues = ["Home", "Departments", "Doctors", "Settings"];
  Map active = {"page": 0, "indicator": 22.00};
  double width = 40;
  late String name, avai, occ;

  List departments = [];

  adddepartment() async {
    final response = await http.post(
      Uri.parse('http://93fd4e66c308.ngrok.io/api/department/add'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "department_name": name,
        "available_bed": avai,
        "occupied_bed": occ
      }),
    );
    if (response.statusCode == 200) {
      var serverResponse = response.body;
      print(serverResponse);
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => Home(
                  id: widget.id,
                  initpage: 1,
                )));
  }

  @override
  void initState() {
    super.initState();
    active["page"] = widget.initpage;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          Positioned(
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              color: Colors.lightBlue[100],
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: 160,
                        child: Image.asset(
                          "assets/aayu16.png",
                          fit: BoxFit.fitWidth,
                        )),
                    Container(
                      width: 445,
                      padding: EdgeInsets.all(16),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: menues
                                  .map((menu) => GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            active["page"] =
                                                menues.indexOf(menu);
                                            width = 120;
                                          });
                                          await Future.delayed(
                                            Duration(milliseconds: 150),
                                          );
                                          setState(() {
                                            width = 40;
                                            if (active["page"] == 0)
                                              active["indicator"] = 22;
                                            if (active["page"] == 1) {
                                              active["indicator"] = 104;
                                              width = 60;
                                            }
                                            if (active["page"] == 2)
                                              active["indicator"] = 242;
                                            if (active["page"] == 3)
                                              active["indicator"] = 338;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              16, 0, 16, 0),
                                          child: Text(
                                            menu,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              height: 10,
                              child: Stack(children: [
                                AnimatedPositioned(
                                  curve: Curves.decelerate,
                                  duration: Duration(
                                    milliseconds: 300,
                                  ),
                                  left: active["indicator"],
                                  child: AnimatedContainer(
                                    duration: Duration(
                                      milliseconds: 150,
                                    ),
                                    height: 3,
                                    width: width,
                                    color: Colors.white,
                                  ),
                                ),
                              ]),
                            )
                          ]),
                    ),
                  ]),
            ),
          ),
          AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              top: 80,
              left:
                  active["page"] == 0 ? 0 : -MediaQuery.of(context).size.width,
              child: Cases()),
          AnimatedPositioned(
            child: Department(),
            duration: Duration(milliseconds: 500),
            top: 80,
            left: active["page"] == 1
                ? 0
                : active["page"] == 0
                    ? MediaQuery.of(context).size.width
                    : -MediaQuery.of(context).size.width,
          ),
          AnimatedPositioned(
            child: Doctors(),
            duration: Duration(milliseconds: 500),
            top: 80,
            left: active["page"] == 2 ? 0 : -MediaQuery.of(context).size.width,
          ),
          AnimatedPositioned(
            child: Settings(id: widget.id),
            duration: Duration(milliseconds: 500),
            top: 80,
            left: active["page"] == 3 ? 0 : MediaQuery.of(context).size.width,
          ),
          AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              top: 80,
              left: active["page"] == 1
                  ? 0
                  : active["page"] == 0
                      ? MediaQuery.of(context).size.width
                      : -MediaQuery.of(context).size.width,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.85,
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: Colors.white,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              height: 150,
                              width: 200,
                              child: Column(children: [
                                TextField(
                                  onChanged: (val) {
                                    setState(() {
                                      name = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Enter Department Name",
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  width: 300,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Available Beds",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          child: TextField(
                                            onChanged: (val) {
                                              setState(() {
                                                avai = val;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(4),
                                                border: OutlineInputBorder()),
                                          ),
                                        ),
                                        Text(
                                          "Occupied Beds",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          child: TextField(
                                            onChanged: (val) {
                                              setState(() {
                                                occ = val;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(4),
                                                border: OutlineInputBorder()),
                                          ),
                                        ),
                                      ]),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                GestureDetector(
                                  onTap: adddepartment,
                                  child: Container(
                                    width: 100,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blue),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Center(child: Text("SUBMIT")),
                                  ),
                                )
                              ]),
                            ),
                          );
                        });
                  },
                  child: Icon(Icons.add),
                ),
              )),
          AnimatedPositioned(
              top: 80,
              left: active["page"] == 3 ? 0 : MediaQuery.of(context).size.width,
              child: Container(),
              duration: Duration(milliseconds: 500))
        ]),
      ),
    );
  }
}
