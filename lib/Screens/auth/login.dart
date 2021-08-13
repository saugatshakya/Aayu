import 'dart:convert';
import 'package:aayu/Screens/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username = "xyz";
  String password = "xyz";
  bool loading = false;
  BorderRadius radius = BorderRadius.only(
      topLeft: Radius.circular(50),
      bottomLeft: Radius.circular(50),
      bottomRight: Radius.circular(50));
  late InputBorder border;
  _login() async {
    setState(() {
      loading = true;
    });
    final response = await http.post(
      Uri.parse('http://93fd4e66c308.ngrok.io/api/user/login'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"username": username, "password": password}),
    );
    if (response.statusCode == 200) {
      var serverResponse = response.body;
      Future.delayed(Duration(seconds: 2)).then((value) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      id: int.parse(serverResponse),
                      initpage: 0,
                    )));
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
    border = OutlineInputBorder(
        borderSide: BorderSide(color: Colors.lightBlue, width: 2),
        borderRadius: radius);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.lightBlue, width: 2),
            borderRadius: radius),
        height: 300,
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 16,
            ),
            Text(
              "LOGIN",
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
                    labelText: "Username",
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
                obscureText: true,
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
                          "New? SignIn",
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
                      onTap: loading ? null : _login,
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: radius,
                          border: Border.all(color: Colors.lightBlue, width: 2),
                        ),
                        child: Center(
                            child: loading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "LOGIN",
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
