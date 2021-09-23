import 'dart:math';

import 'package:flutter/material.dart';

class Case extends StatefulWidget {
  final Map obj;
  final List doctors;
  final VoidCallback sel, rel;
  Case(
      {required this.obj,
      required this.doctors,
      required this.sel,
      required this.rel});
  @override
  _CaseState createState() => _CaseState(obj: obj);
}

class _CaseState extends State<Case> {
  final Map obj;
  _CaseState({required this.obj});
  List states = ["new", "active", "completed"];
  List<Color> colors = [
    Color(0xffB3E5FC),
    Color(0xffb3fcd4),
    Color(0xfffcb3b3)
  ];
  List casts = [
    "Chaudhary",
    "Tamang",
    "Gurung",
    "Thapa",
    "Rana",
    "Yadav",
    "Magar",
    "Rai",
    "Shrestha",
    "Lama",
    "Chhetri",
    "Shah",
    "Sharma",
    "Singh",
    "Bishwakarma",
    "Maharjan",
    "Nepali",
    "Pariyar",
    "Pokharel",
    "Tharu"
  ];
  List persons = [
    {"name": "Hari", "sex": "Male"},
    {"name": "Milan", "sex": "Male"},
    {"name": "Kamal", "sex": "Male"},
    {"name": "Bibek", "sex": "Male"},
    {"name": "Bikash", "sex": "Male"},
    {"name": "Samir", "sex": "Male"},
    {"name": "Sushant", "sex": "Male"},
    {"name": "Santosh", "sex": "Male"},
    {"name": "Binod", "sex": "Male"},
    {"name": "Rohit", "sex": "Male"},
    {"name": "Rakesh", "sex": "Male"},
    {"name": "Anjan", "sex": "Male"},
    {"name": "Srijan", "sex": "Male"},
    {"name": "Kiran", "sex": "Male"},
    {"name": "Ananta", "sex": "Male"},
    {"name": "Rajiv", "sex": "Male"},
    {"name": "Anish", "sex": "Male"},
    {"name": "Pramod", "sex": "Male"},
    {"name": "Sushil", "sex": "Male"},
    {"name": "Dipesh", "sex": "Male"},
    {"name": "Rohan", "sex": "Male"},
    {"name": "Simrika", "sex": "Female"},
    {"name": "Sona", "sex": "Female"},
    {"name": "Kusum", "sex": "Female"},
    {"name": "Niharika", "sex": "Female"},
    {"name": "Nisu", "sex": "Female"},
    {"name": "Soneeya", "sex": "Female"},
    {"name": "Yashoda", "sex": "Female"},
    {"name": "Reshma", "sex": "Female"},
    {"name": "Roshika", "sex": "Female"},
    {"name": "Alina", "sex": "Female"},
    {"name": "Amita", "sex": "Female"},
    {"name": "Sneha", "sex": "Female"},
    {"name": "Samikchya", "sex": "Female"},
    {"name": "Mahima", "sex": "Female"},
    {"name": "Prapti", "sex": "Female"},
    {"name": "Sanjita", "sex": "Female"},
  ];
  List bloodgroup = ["O+", "O-", "A+", "A-", "B+", "B-", "AB+", "AB-"];
  List<Color> textcolors = [Colors.blue, Colors.green, Colors.red];
  @override
  void initState() {
    print(obj["status"] == "new");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int person = Random().nextInt(persons.length);
    int cast = Random().nextInt(casts.length);
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
              Text(obj["name"],
                  style: TextStyle(
                      color: textcolors[states.indexOf(obj["status"])])),
              Text(obj["sex"],
                  style: TextStyle(
                      color: textcolors[states.indexOf(obj["status"])])),
              Text(
                obj["age"],
                style:
                    TextStyle(color: textcolors[states.indexOf(obj["status"])]),
              )
            ],
          ),
        ),
        horizontalTitleGap: 0,
        trailing: Column(children: [
          Container(
            width: obj["status"] == "new" ? 120 : 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  width: 2,
                  color: obj["status"] == "new"
                      ? colors[states.indexOf(obj["status"])]
                      : Colors.transparent),
            ),
            child: Center(
                child: GestureDetector(
              onTap: obj["status"] == "new"
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
                                        onTap: widget.sel,
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
                                                        ["doctor_name"],
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    widget.doctors[i]["status"],
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
                  : widget.rel,
              child: Text(
                obj["status"] == "new"
                    ? "Assign Doctor"
                    : "Assigned Doctor: Arbin",
                style:
                    TextStyle(color: textcolors[states.indexOf(obj["status"])]),
              ),
            )),
          ),
          SizedBox(
            height: 8,
          ),
          obj["status"] == "new"
              ? SizedBox.shrink()
              : Container(
                  width: obj["status"] == "new" ? 120 : 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        width: 2,
                        color: obj["status"] == "new"
                            ? colors[states.indexOf(obj["status"])]
                            : Colors.transparent),
                  ),
                  child: Center(
                      child: Text(
                    obj["status"] == "new" ? "Assign Bed" : "Skin Dep",
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
          Text(
            obj["case"] + "   " + obj["bloodGroup"],
            style: TextStyle(color: textcolors[states.indexOf(obj["status"])]),
          ),
          Text(
            "August " + 27.toString(),
            style: TextStyle(color: textcolors[states.indexOf(obj["status"])]),
          )
        ]),
      ),
    );
  }
}

List number = ["anil", "bafw", "cadwf", 5];
