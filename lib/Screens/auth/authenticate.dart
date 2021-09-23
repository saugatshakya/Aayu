import 'package:aayu/Screens/auth/login.dart';
import 'package:aayu/Screens/auth/signup.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  GlobalKey<FlipCardState> login = GlobalKey<FlipCardState>();
  GlobalKey<FlipCardState> signup = GlobalKey<FlipCardState>();
  int active = 0;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://i.ibb.co/fGyWBrG/pexels-pixabay-40568.jpg"),
                fit: BoxFit.cover)),
        child: Stack(children: [
          Positioned(
              top: 40,
              left: 30,
              child: Container(
                width: 240,
                child: Stack(children: [
                  Container(
                      width: 240,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                                width: 250,
                                child: Image.asset("assets/aayu16.png")),
                            Container(
                              width: 200,
                              height: 2,
                              color: Colors.lightBlue,
                            )
                          ])),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Text(
                      "Hospital",
                      style:
                          TextStyle(color: Colors.lightBlue[300], fontSize: 24),
                    ),
                  ),
                ]),
              )),
          Center(
            child: Container(
              width: 700,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (active == 2) {
                          signup.currentState!.toggleCard();
                          active = 1;
                        } else if (active == 1) {
                          active = 0;
                        } else {
                          active = 1;
                        }
                        login.currentState!.toggleCard();
                      });
                    },
                    child: FlipCard(
                      key: login,
                      flipOnTouch: false,
                      back: Login(),
                      front: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            border: Border.all(color: Colors.white, width: 5)),
                        child: Center(
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (active == 2) {
                          active = 0;
                        } else if (active == 1) {
                          active = 2;
                          login.currentState!.toggleCard();
                        } else {
                          active = 2;
                        }
                        signup.currentState!.toggleCard();
                      });
                    },
                    child: FlipCard(
                      key: signup,
                      flipOnTouch: false,
                      back: Signup(),
                      front: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            border: Border.all(color: Colors.white, width: 5)),
                        child: Center(
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
