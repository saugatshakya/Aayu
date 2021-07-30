import 'dart:math';

import 'package:flutter/material.dart';

class Doctors extends StatefulWidget {
  const Doctors({Key? key}) : super(key: key);

  @override
  _DoctorsState createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
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
              for (int i = 0; i < 8; i++)
                Container(
                  color: Colors.lightBlue[200],
                  margin: const EdgeInsets.all(8.0),
                  child: GridTile(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(
                              child: Icon(Icons.person, color: Colors.white)),
                          Text(
                            "Name",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            Random().nextBool() ? "Available" : "Busy",
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
