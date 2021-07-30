import 'dart:async';

import 'package:aayu/Screens/cases.dart';
import 'package:aayu/Screens/department.dart';
import 'package:aayu/Screens/doctors.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List menues = ["Home", "Departments", "Doctors", "Settings"];
  Map active = {"page": 0, "indicator": 22.00};
  double width = 40;
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
            left: active["page"] == 1 ? 0 : -MediaQuery.of(context).size.width,
          ),
          AnimatedPositioned(
            child: Doctors(),
            duration: Duration(milliseconds: 500),
            top: 80,
            left: active["page"] == 2 ? 0 : -MediaQuery.of(context).size.width,
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
                  onPressed: () {},
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
