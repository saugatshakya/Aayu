import 'package:flutter/material.dart';

class Department extends StatefulWidget {
  const Department({Key? key}) : super(key: key);

  @override
  _DepartmentState createState() => _DepartmentState();
}

class _DepartmentState extends State<Department> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 3; i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ListTile(
                      tileColor: Colors.lightBlue,
                      dense: true,
                      title: Text("Department Name",
                          style: TextStyle(
                            color: Colors.white,
                          ))),
                ),
              )
          ],
        ),
      ),
    );
  }
}
