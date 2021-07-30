import 'package:aayu/Screens/auth/authenticate.dart';
import 'package:aayu/Screens/auth/login.dart';
import 'package:aayu/Screens/home.dart';
import 'package:aayu/Screens/loading.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aayu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Loading(),
    );
  }
}
