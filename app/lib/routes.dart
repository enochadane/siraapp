import 'package:app/presentation/screens/admin/dashboard.dart';
import 'package:app/presentation/screens/common/common.dart';
import 'package:app/presentation/screens/common/login_screen.dart';
import 'package:app/presentation/screens/employer/employer_homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication/authentication.dart';
import 'presentation/screens/job_seeker/seeker_homepage.dart';

class MyPageRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        {
          return MaterialPageRoute(builder: (context) {
            return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
              if (state is AuthenticationAuthenticated) {
                if (state.user.role == "ADMIN") {
                  return AdminDashboard();
                } else if (state.user.role == "EMPLOYER") {
                  return EmployerHomePage();
                } else {
                  return SeekerHomePage();
                }
              }
              // otherwise show login page
              return LoginPage();
            });
          });
        }
      case "/login":
        {
          return MaterialPageRoute(builder: (context) {
            return LoginPage();
          });
        }
      case "/register":
        {
          return MaterialPageRoute(builder: (context) {
            return SignUpPage();
          });
        }
      default:
        {
          return null;
        }
    }
  }
}
