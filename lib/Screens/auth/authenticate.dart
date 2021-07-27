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
        child: Center(
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
                    print(active);
                  },
                  child: FlipCard(
                    key: login,
                    flipOnTouch: false,
                    back: Login(),
                    front: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50)),
                        color: Colors.blue,
                      ),
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
                    print(active);
                  },
                  child: FlipCard(
                    key: signup,
                    flipOnTouch: false,
                    back: Signup(),
                    front: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50)),
                        color: Colors.blue,
                      ),
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
      ),
    );
  }
}
