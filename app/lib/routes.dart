import 'package:app/presentation/screens/common/login_screen.dart';
import 'package:app/presentation/screens/employer/employer_homepage.dart';
import 'package:app/presentation/screens/employer/seeker_homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication/authentication.dart';

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
                  return EmployerHomePage();
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
            return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
              if (state is AuthenticationNotAuthenticated) {
                // otherwise show login page
                // show home page
              }
              if (state is AuthenticationAuthenticated) {
                if (state.user.role == "ADMIN") {
                  return EmployerHomePage();
                } else if (state.user.role == "EMPLOYER") {
                  return EmployerHomePage();
                } else {
                  return SeekerHomePage();
                }
              }
              // return HomePage(
              //   user: state.user,
              // );
              return LoginPage();
            });
          });
        }
      default:
        {
          return MaterialPageRoute(builder: (context) {
            return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
              if (state is AuthenticationAuthenticated)
                // return HomePage(
                // user: state.user,
                // );
                // if (state is AuthenticationNotAuthenticated) {
                // otherwise show login page
                return LoginPage();
              // show home page
              // }
            });
          });
        }
    }
  }
}
