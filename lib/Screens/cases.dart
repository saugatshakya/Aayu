import 'dart:convert';

import 'package:aayu/Screens/Components/case.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Cases extends StatefulWidget {
  final int id;
  Cases({required this.id});
  @override
  _CasesState createState() => _CasesState();
}

class _CasesState extends State<Cases> {
  List doctors = [];

  int active = 1;
  List menues = ["New Case", "Active Case", "Completed Case"];
  List cases = [];
  getallcases() async {
    final response = await http.get(
      Uri.parse('https://call-db-aayu.herokuapp.com/api/cases/list'),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      var serverResponse = response.body;
      cases = jsonDecode(serverResponse);
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }

  getalldoctors() async {
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
    super.initState();
    getallcases();
    getalldoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(children: [
        Positioned(
          top: 0,
          left: MediaQuery.of(context).size.width * 0.5 - 250,
          child: Container(
            width: 500,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.lightBlue[100],
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(900))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: menues
                  .map((menu) => GestureDetector(
                        onTap: () {
                          setState(() {
                            active = menues.indexOf(menu);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Text(
                            menu,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: active == menues.indexOf(menu)
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize:
                                    active == menues.indexOf(menu) ? 22 : 18),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 500),
          top: 50,
          left: active == 0 ? 0 : -MediaQuery.of(context).size.width,
          child: Container(
            margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(width: 2, color: Color(0xffB3E5FC)),
            ),
            width: MediaQuery.of(context).size.width * 0.96,
            height: MediaQuery.of(context).size.height * 0.82,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < cases.length; i++)
                    cases[i]["status"] == "New"
                        ? Case(
                            id: widget.id,
                            obj: cases[i],
                            doctors: doctors,
                          )
                        : SizedBox.shrink()
                ],
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 500),
          top: 50,
          left: active == 1
              ? 0
              : active == 0
                  ? MediaQuery.of(context).size.width
                  : -MediaQuery.of(context).size.width,
          child: Container(
            margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(width: 2, color: Color(0xffb3fcd4)),
            ),
            width: MediaQuery.of(context).size.width * 0.96,
            height: MediaQuery.of(context).size.height * 0.82,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < cases.length; i++)
                    cases[i]["status"] == "Active"
                        ? Case(
                            id: widget.id,
                            obj: cases[i],
                            doctors: doctors,
                          )
                        : SizedBox.shrink()
                ],
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 500),
          top: 50,
          left: active == 0
              ? MediaQuery.of(context).size.width
              : active == 1
                  ? MediaQuery.of(context).size.width
                  : 0,
          child: Container(
            margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(width: 2, color: Color(0xfffcb3b3)),
            ),
            width: MediaQuery.of(context).size.width * 0.96,
            height: MediaQuery.of(context).size.height * 0.82,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < cases.length; i++)
                    cases[i]["status"] == "Completed"
                        ? Case(
                            id: widget.id,
                            obj: cases[i],
                            doctors: doctors,
                          )
                        : SizedBox.shrink()
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
