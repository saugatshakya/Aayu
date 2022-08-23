import 'dart:convert';
import 'dart:math';
import 'package:aayu/Screens/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Case extends StatefulWidget {
  final id;
  final Map obj;
  final List doctors;
  Case({
    required this.id,
    required this.obj,
    required this.doctors,
  });
  @override
  _CaseState createState() => _CaseState(obj: obj);
}

class _CaseState extends State<Case> {
  final Map obj;
  _CaseState({required this.obj});
  List states = ["New", "Active", "Completed"];
  List<Color> colors = [
    Color(0xffB3E5FC),
    Color(0xffb3fcd4),
    Color(0xfffcb3b3)
  ];

  List<Color> textcolors = [Colors.blue, Colors.green, Colors.red];

  assignDoctor(id) async {
    print(id);
    final response = await http.post(
      Uri.parse(
          'https://call-db-aayu.herokuapp.com/api/cases/doctor/${obj["cases_id"]}'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"doctor_id": id}),
    );
    print(response.body);
    if (response.statusCode == 200) {
      var serverResponse = response.body;
      print(serverResponse);
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }

  removeDoctor() async {
    final response = await http.post(
      Uri.parse('https://call-db-aayu.herokuapp.com/api/cases/delete_doctor'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"cases_id": obj["cases_id"]}),
    );
    print(response.body);
    if (response.statusCode == 200) {
      var serverResponse = response.body;
      print(serverResponse);
      setState(() {});
      await Future.delayed(Duration(milliseconds: 1000));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Home(id: widget.id, initpage: 0)));
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    print(obj);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String urgency = Random().nextInt(100) > 70 ? "Regular" : "Emergency";
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border:
            Border.all(width: 2, color: colors[states.indexOf(obj["status"])]),
      ),
      width: MediaQuery.of(context).size.width * 0.96,
      height: 80,
      child: ListTile(
        leading: Container(
          width: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(obj["patient"]["patient_name"],
                  style: TextStyle(
                      color: textcolors[states.indexOf(obj["status"])])),
              Text(obj["patient"]["sex"] ?? "xx",
                  style: TextStyle(
                      color: textcolors[states.indexOf(obj["status"])])),
              Text(
                obj["patient"]["age"].toString(),
                style:
                    TextStyle(color: textcolors[states.indexOf(obj["status"])]),
              )
            ],
          ),
        ),
        horizontalTitleGap: 0,
        trailing: Column(children: [
          Container(
            width: obj["status"] == "New" ? 120 : 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  width: 2,
                  color: obj["status"] == "New"
                      ? colors[states.indexOf(obj["status"])]
                      : Colors.transparent),
            ),
            child: Center(
                child: GestureDetector(
              onTap: obj["status"] == "New"
                  ? () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: Container(
                                width: 500,
                                height: 500,
                                child: GridView.count(
                                  crossAxisCount: 5,
                                  children: [
                                    for (int i = 0;
                                        i < widget.doctors.length;
                                        i++)
                                      GestureDetector(
                                        onTap: () async {
                                          print("working");
                                          assignDoctor(
                                              widget.doctors[i]["doctor_id"]);
                                          await Future.delayed(
                                              Duration(milliseconds: 1000));
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Home(
                                                      id: widget.id,
                                                      initpage: 0)));
                                        },
                                        child: Container(
                                          color: Colors.lightBlue[200],
                                          margin: const EdgeInsets.all(8.0),
                                          child: GridTile(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                      child: Icon(Icons.person,
                                                          color: Colors.white)),
                                                  Text(
                                                    widget.doctors[i]
                                                            ["doctor_name"] ??
                                                        "xx",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    widget.doctors[i]
                                                            ["status"] ??
                                                        "xx",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  : obj["status"] == "Active"
                      ? removeDoctor
                      : () {},
              child: Text(
                obj["status"] == "New"
                    ? "Assign Doctor"
                    : obj["status"] == "Active"
                        ? "Assigned Doctor: " + obj["doctor"]["doctor_name"]
                        : "",
                style:
                    TextStyle(color: textcolors[states.indexOf(obj["status"])]),
              ),
            )),
          ),
          SizedBox(
            height: 8,
          ),
          obj["status"] == "New"
              ? SizedBox.shrink()
              : Container(
                  width: obj["status"] == "New" ? 120 : 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        width: 2,
                        color: obj["status"] == "New"
                            ? colors[states.indexOf(obj["status"])]
                            : Colors.transparent),
                  ),
                  child: Center(
                      child: Text(
                    obj["status"] == "New" ? "Assign Bed" : "Skin Dep",
                    style: TextStyle(
                        color: textcolors[states.indexOf(obj["status"])]),
                  )),
                )
        ]),
        title: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            urgency,
            style: TextStyle(color: textcolors[states.indexOf(obj["status"])]),
          ),
        ),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text(
              obj["patient"]["patient_case"] ?? "xx",
              style:
                  TextStyle(color: textcolors[states.indexOf(obj["status"])]),
            ),
            Text(
              obj["patient"]["blood_group"] ?? "xx",
              style:
                  TextStyle(color: textcolors[states.indexOf(obj["status"])]),
            ),
          ]),
          Text(
            "September " + 24.toString(),
            style: TextStyle(color: textcolors[states.indexOf(obj["status"])]),
          )
        ]),
      ),
    );
  }
}
