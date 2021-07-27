import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  BorderRadius radius = BorderRadius.only(
      topLeft: Radius.circular(50),
      bottomLeft: Radius.circular(50),
      bottomRight: Radius.circular(50));
  late InputBorder border;
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
                    Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: radius,
                        border: Border.all(color: Colors.lightBlue, width: 2),
                      ),
                      child: Center(
                          child: Text(
                        "LOGIN",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      )),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
