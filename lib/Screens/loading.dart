import 'dart:async';

import 'package:aayu/Screens/auth/authenticate.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  int active = 5;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 65), (time) {
      setState(() {
        if (active > 9) {
          active = 0;
        }
        active++;
      });
    });
    Future.delayed(Duration(seconds: 2)).then((value) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => Auth())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Container(
          width: 400,
          height: 200,
          child: Stack(
            children: [
              for (int i = 0; i < 10; i++)
                AnimatedPositioned(
                    curve: Curves.decelerate,
                    duration: Duration(milliseconds: 35),
                    bottom: active == i
                        ? 0
                        : active == i - 1 || active == i + 1
                            ? 25
                            : active == i - 2 || active == i + 2
                                ? 50
                                : 80,
                    left: i * 40,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 35),
                      curve: Curves.decelerate,
                      height: active == i
                          ? 70
                          : active == i - 1 || active == i + 1
                              ? 50
                              : active == i - 2 || active == i + 2
                                  ? 25
                                  : active == i - 3 || active == i + 3
                                      ? 25
                                      : active == i - 4 || active == i + 4
                                          ? 50
                                          : 75,
                      width: 10,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                active == i - 2 ||
                                        active == i - 1 ||
                                        active == i ||
                                        active == i + 1 ||
                                        active == i + 2
                                    ? Colors.lightBlue
                                    : Colors.white,
                                Colors.lightBlue,
                                Colors.lightBlue,
                                active == i - 2 ||
                                        active == i - 1 ||
                                        active == i ||
                                        active == i + 1 ||
                                        active == i + 2
                                    ? Colors.white
                                    : Colors.lightBlue
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.vertical(
                            top: active == i - 2 ||
                                    active == i - 1 ||
                                    active == i ||
                                    active == i + 1 ||
                                    active == i + 2
                                ? Radius.circular(10)
                                : Radius.circular(0),
                            bottom: active == i - 2 ||
                                    active == i - 1 ||
                                    active == i ||
                                    active == i + 1 ||
                                    active == i + 2
                                ? Radius.circular(0)
                                : Radius.circular(10),
                          )),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
