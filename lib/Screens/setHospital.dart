import 'dart:convert';

import 'package:aayu/Screens/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SetHospital extends StatefulWidget {
  const SetHospital({Key? key}) : super(key: key);

  @override
  _SetHospitalState createState() => _SetHospitalState();
}

class _SetHospitalState extends State<SetHospital> {
  String name = "";
  hospitalRegister() async {
    final response = await http.post(
      Uri.parse('https://call-db-aayu.herokuapp.com/api/hospital/register'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"hospital_name": name}),
    );
    if (response.statusCode == 200) {
      var serverResponse = jsonDecode(response.body);
      print(serverResponse);

      Future.delayed(Duration(seconds: 2)).then((value) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      id: serverResponse,
                      initpage: 0,
                    )));
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.lightBlue[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 300,
                child: TextField(
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                )),
            GestureDetector(
              onTap: hospitalRegister,
              child: Container(
                width: 100,
                height: 40,
                color: Colors.lightBlue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
