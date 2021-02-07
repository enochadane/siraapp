
import 'package:app/presentation/screens/common/login_screen.dart';
import 'package:flutter/material.dart';

// import 'package:app/presentation/screens/screens.dart';



class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Portal',
      home: LoginPage(),
    );
  }
}