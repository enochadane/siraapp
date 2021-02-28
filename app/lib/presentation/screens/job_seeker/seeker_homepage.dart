import 'package:flutter/material.dart';

class EmployerHomePage extends StatelessWidget {
  static const String routeName = "/employer";
  const EmployerHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
        child: Container(child: Text("HomePage"),),
      ),
    );
  }
}
