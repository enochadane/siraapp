import 'package:app/blocs/job/job.dart';
import 'package:app/presentation/screens/admin/dashboard.dart';
import 'package:app/presentation/screens/common/common.dart';
import 'package:app/presentation/screens/common/home_page.dart';
import 'package:app/presentation/screens/common/login_screen.dart';
import 'package:app/presentation/screens/screens.dart';
import 'package:app/repositories/job_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication/authentication.dart';
import 'data_provider/data_provider.dart';
import 'models/models.dart';
import 'repositories/repository.dart';

class MyPageRouter {
// this techinique is called dependency injection
  final JobRepository jobRepository = JobRepository(
    dataProvider: JobDataProvider(),
  );

  final JobCategoryRepository jobCategoryRepository = JobCategoryRepository(
    dataProvider: JobCategoryDataProvider(),
  );

  Route onGenerateRoute(RouteSettings settings) {
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
                  return BlocProvider<JobBloc>(
                    create: (context) => JobBloc(jobRepository: jobRepository)
                      ..add(JobLoad(user: state.user)),
                    child: HomePage(
                      user: state.user,
                    ),
                  );
                } else if (state.user.role == "SEEKER") {
                  return BlocProvider<JobBloc>(
                    create: (context) => JobBloc(jobRepository: jobRepository)
                      ..add(JobLoad(user: state.user)),
                    child: HomePage(
                      user: state.user,
                    ),
                  );
                }
              }
              // otherwise show login page
              return LoginPage();
            });
          });
        }
      case LoginPage.routeName:
        {
          return MaterialPageRoute(builder: (context) {
            return LoginPage();
          });
        }
      case SignUpPage.routeName:
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
          SingleJobDetailArguments args = settings.arguments;
          print("args are ${args.user.username}");
          return MaterialPageRoute(
              builder: (context) => BlocProvider<JobBloc>.value(
                  value: JobBloc(jobRepository: jobRepository),
                  child: (JobDetails(
                    user: args.user,
                    selectedJob: args.selectedJob,
                  ))));
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

class JobDetailArgument {
  final User user;
  final Job job;

  JobDetailArgument({this.user, @required this.job});
}
