import 'dart:convert';

import 'package:aayu/Screens/home.dart';
import 'package:aayu/Screens/setHospital.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool loading = false;
  String username = "xyz";
  String password = "xyz";
  _register() async {
    setState(() {
      loading = true;
    });
    final response = await http.post(
      Uri.parse('https://call-db-aayu.herokuapp.com/api/user/register'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"username": username, "password": password}),
    );
    if (response.statusCode == 200) {
      var serverResponse = response.body;
      if (int.parse(serverResponse) < 5000) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SetHospital(
                      id: serverResponse,
                    )));
      }
    } else {
      print(response.reasonPhrase);
    }
    setState(() {
      loading = false;
    });
  }

  late InputBorder border;
  @override
  void initState() {
    super.initState();
    border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlue, width: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.lightBlue, width: 5),
        ),
        height: 300,
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 16,
            ),
            Text(
              "SIGN UP",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Colors.lightBlue),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
                onChanged: (val) {
                  setState(() {
                    username = val;
                  });
                },
                decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.lightBlue),
                    enabledBorder: border,
                    errorBorder: border,
                    focusedBorder: border,
                    disabledBorder: border)),
            SizedBox(
              height: 8,
            ),
            TextFormField(
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
                decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.lightBlue),
                    enabledBorder: border,
                    errorBorder: border,
                    focusedBorder: border,
                    disabledBorder: border)),
            SizedBox(
              height: 32,
            ),
            Container(
              width: 300,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Already a user? LogIn",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.lightBlue),
                        ),
                        Text(
                          "Forgot Password !",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.lightBlue),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: _register,
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          border: Border.all(color: Colors.lightBlue, width: 2),
                        ),
                        child: Center(
                            child: loading
                                ? Container(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    "SIGNUP",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  )),
                      ),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
