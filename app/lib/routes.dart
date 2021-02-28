import 'dart:js';

import 'package:app/presentation/screens/admin/dashboard.dart';
import 'package:app/presentation/screens/common/common.dart';
import 'package:app/presentation/screens/common/home_page.dart';
import 'package:app/presentation/screens/common/login_screen.dart';
import 'package:app/presentation/screens/employer/employer_homepage.dart';
import 'package:app/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication/authentication.dart';
import 'models/models.dart';
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
                  return HomePage(
                    userType: 'EMPLOYER',
                  );
                } else if (state.user.role == "SEEKER") {
                  return HomePage(
                    userType: 'SEEKER',
                  );
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
      case ApplicationList.route:
        {
          return MaterialPageRoute(
            builder: (context) => ApplicationList(),
          );
        }
        break;
      case ApplicationDetails.route:
        {
          Application application = settings.arguments;
          return MaterialPageRoute(
            builder: (context) => ApplicationDetails(
              application: application,
            ),
          );
        }
        break;
      case AddUpdateApplication.route:
        {
          ApplicationArgument args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) => AddUpdateApplication(
              args: args,
            ),
          );
        }
      case CreateEditJobPage.routeName:
        {
          return MaterialPageRoute(
            builder: (context) => CreateEditJobPage(),
          );
        }
      case JobDetails.routeName:
        {
          return MaterialPageRoute(
            builder: (context) => JobDetails(),
          );
        }
      default:
        {
          return null;
        }
    }
  }
}

class ApplicationArgument {
  final Application application;
  final bool edit;
  ApplicationArgument({this.application, this.edit});
}
