import 'package:app/blocs/application/application.dart';
import 'package:app/blocs/authentication/user/user.dart';
import 'package:app/blocs/job/job.dart';
import 'package:app/blocs/role/role.dart';
import 'package:app/blocs/role/role_bloc.dart';
import 'package:app/presentation/screens/admin/create_role.dart';
import 'package:app/presentation/screens/admin/dashboard.dart';
import 'package:app/presentation/screens/admin/role_change.dart';
import 'package:app/presentation/screens/common/common.dart';
import 'package:app/presentation/screens/common/home_page.dart';
import 'package:app/presentation/screens/common/login_screen.dart';
import 'package:app/presentation/screens/common/user_edit.dart';
import 'package:app/presentation/screens/screens.dart';
import 'package:app/repositories/job_repository.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'blocs/authentication/authentication.dart';
import 'data_provider/data_provider.dart';
import 'models/models.dart';
import 'repositories/repository.dart';

class MyPageRouter {
// this techinique is called dependency injection
  final JobRepository jobRepository = JobRepository(
    dataProvider: JobDataProvider(),
  );

  final RoleRepository roleRepository = RoleRepository(
    dataProvider: RoleDataProvider(),
  );

  final UserRepository userRepository = UserRepository(
    dataProvider: UserDataProvider(),
  );

  final JobCategoryRepository jobCategoryRepository = JobCategoryRepository(
    dataProvider: JobCategoryDataProvider(),
  );

  final ApplicationRepository applicationRepository = ApplicationRepository(
    dataProvider: ApplicationDataProvider(
      httpClient: http.Client(),
    ),
  );

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        {
          return MaterialPageRoute(builder: (context) {
            return BlocConsumer<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is AuthenticationAuthenticated) {
                    if (state.user.role == "ADMIN") {
                      return MultiBlocProvider(providers: [
                        BlocProvider<UserBloc>(
                            create: (context) =>
                                UserBloc(userRepository: userRepository)
                                  ..add(UserLoad())),
                        BlocProvider<RoleBloc>(
                            create: (context) =>
                                RoleBloc(roleRepository: roleRepository)
                                  ..add(RoleLoad())),
                      ], child: AdminDashboard());
                    } else if (state.user.role == "EMPLOYER") {
                      return BlocProvider<JobBloc>(
                        lazy: false,
                        create: (context) =>
                            JobBloc(jobRepository: jobRepository)
                              ..add(JobLoad(user: state.user)),
                        child: HomePage(
                          user: state.user,
                        ),
                      );
                    } else {
                      return BlocProvider<JobBloc>(
                        create: (context) =>
                            JobBloc(jobRepository: jobRepository)
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
      case CreateRole.routeName:
        {
          return MaterialPageRoute(
              builder: (context) => BlocProvider<RoleBloc>.value(
                  value: RoleBloc(roleRepository: roleRepository),
                  child: RepositoryProvider<JobCategoryRepository>.value(
                    value: jobCategoryRepository,
                    child: CreateRole(),
                  )));
        }
      case ChangeRole.routeName:
        {
          User user = settings.arguments;
          return MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                  value: UserBloc(userRepository: userRepository),
                  child: BlocProvider<RoleBloc>(
                    create: (context) =>
                        RoleBloc(roleRepository: roleRepository)
                          ..add(RoleLoad()),
                    // create: RoleBloc(roleRepository: roleRepository),
                    child: ChangeRole(
                      user: user,
                    ),
                  )));
        }
      case SignUpPage.routeName:
        {
          return MaterialPageRoute(builder: (context) {
            return SignUpPage();
          });
        }
      case ApplicationList.route:
        {
          ApplicationArgument args = settings.arguments;
          print("${args.job} is the jbo");
          return MaterialPageRoute(builder: (context) {
            return BlocProvider<ApplicationBloc>(
                create: (context) => ApplicationBloc(
                    applicationRepository: applicationRepository)
                  ..add(ApplicationLoad(job: args.job, user: args.user)),
                child: ApplicationList(args: args));
          });
        }
        break;
      case ApplicationDetails.route:
        {
          // Application application = settings.arguments;
          ApplicationArgument args = settings.arguments;
          print(
              '${args.job} from application details routes *************************');
          return MaterialPageRoute(
            builder: (context) => BlocProvider<ApplicationBloc>.value(
              value:
                  ApplicationBloc(applicationRepository: applicationRepository),
              child: ApplicationDetails(
                args: args,
              ),
            ),
          );
        }
        break;
      case AddUpdateApplication.route:
        {
          ApplicationArgument args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) => BlocProvider<ApplicationBloc>.value(
              value:
                  ApplicationBloc(applicationRepository: applicationRepository),
              child: AddUpdateApplication(
                args: args,
              ),
            ),
          );
        }
      case CreateEditJobPage.routeName:
        {
          final args = settings.arguments;
          return MaterialPageRoute(
              builder: (context) => BlocProvider<JobBloc>.value(
                  value: JobBloc(jobRepository: jobRepository),
                  child: RepositoryProvider<JobCategoryRepository>.value(
                    value: jobCategoryRepository,
                    child: CreateEditJobPage(
                      selectedJob: args,
                    ),
                  )));
        }
      case JobDetails.routeName:
        {
          SingleJobDetailArguments args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) => BlocProvider<JobBloc>.value(
                value: JobBloc(jobRepository: jobRepository),
                child: (JobDetails(
                  user: args.user,
                  selectedJob: args.selectedJob,
                ))),
          );
        }

      case UpdateUser.routeName:
        {
          return MaterialPageRoute(builder: (context) {
            return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
              if (state is AuthenticationAuthenticated) {
                return BlocProvider<UserBloc>.value(
                  value: UserBloc(userRepository: userRepository),
                  child: UpdateUser(loggedInUser: state.user),
                );
              }
              return Container();
            });
          });
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
  final Job job;
  final User user;
  final bool edit;
  ApplicationArgument({this.application, this.edit, this.job, this.user});
}

class JobDetailArgument {
  final User user;
  final Job job;

  JobDetailArgument({this.user, @required this.job});
}
