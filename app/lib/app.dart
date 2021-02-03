
import 'package:flutter/material.dart';

import 'ui/screens/common/login_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Portal',
      home: LoginPage(),
    );
  }
}