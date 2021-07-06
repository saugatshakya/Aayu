import 'dart:math';

import 'package:flutter/material.dart';

class Case extends StatefulWidget {
  final String state;
  Case({required this.state});
  @override
  _CaseState createState() => _CaseState(state: state);
}

class _CaseState extends State<Case> {
  final String state;
  List states = ["new", "active", "completed"];
  List<Color> colors = [
    Color(0xffB3E5FC),
    Color(0xffb3fcd4),
    Color(0xfffcb3b3)
  ];
  List cast = [
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

  _CaseState({required this.state});
  @override
  Widget build(BuildContext context) {
    int person = Random().nextInt(persons.length);
    String urgency = Random().nextInt(100) > 70 ? "Regular" : "Emergency";
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 2, color: colors[states.indexOf(state)]),
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
              Text(
                  persons[person]["name"] +
                      " " +
                      cast[Random().nextInt(cast.length)],
                  style: TextStyle(color: textcolors[states.indexOf(state)])),
              Text(persons[person]["sex"],
                  style: TextStyle(color: textcolors[states.indexOf(state)])),
              Text(
                (Random().nextInt(92) + 1).toString(),
                style: TextStyle(color: textcolors[states.indexOf(state)]),
              )
            ],
          ),
        ),
        horizontalTitleGap: 0,
        trailing: Column(children: [
          Container(
            width: state == "new" ? 120 : 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  width: 2,
                  color: state == "new"
                      ? colors[states.indexOf(state)]
                      : Colors.transparent),
            ),
            child: Center(
                child: Text(
              state == "new"
                  ? "Assign Doctor"
                  : "Assigned Doctor: Jeevan kadel",
              style: TextStyle(color: textcolors[states.indexOf(state)]),
            )),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            width: state == "new" ? 120 : 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  width: 2,
                  color: state == "new"
                      ? colors[states.indexOf(state)]
                      : Colors.transparent),
            ),
            child: Center(
                child: Text(
              state == "new"
                  ? "Assign Bed"
                  : "ER Room " +
                      (Random().nextInt(300 - 100) + 100).toString() +
                      "   " +
                      "  Bed " +
                      (Random().nextInt(200) + 1).toString(),
              style: TextStyle(color: textcolors[states.indexOf(state)]),
            )),
          )
        ]),
        title: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            urgency,
            style: TextStyle(color: textcolors[states.indexOf(state)]),
          ),
        ),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Road accident " +
                "   " +
                bloodgroup[Random().nextInt(bloodgroup.length)],
            style: TextStyle(color: textcolors[states.indexOf(state)]),
          ),
          Text(
            "June " + (Random().nextInt(31) + 1).toString(),
            style: TextStyle(color: textcolors[states.indexOf(state)]),
          )
        ]),
      ),
    );
  }
}
