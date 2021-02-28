
import 'package:app/presentation/screens/admin/dashboard.dart';
import 'package:app/presentation/screens/common/common.dart';
import 'package:app/presentation/screens/common/login_screen.dart';
import 'package:app/presentation/screens/screens.dart';
import 'package:flutter/material.dart';




class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Portal',
      debugShowCheckedModeBanner: false,
      // home: LoginPage(),
      // home: SignUpPage(),
      // home: ProfilePageForm(),
      home: AdminDashboard(),
    );
  }
}