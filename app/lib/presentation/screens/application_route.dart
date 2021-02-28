
import 'package:app/models/application.dart';
import 'package:flutter/material.dart';

import 'common/application_details.dart';
import 'common/application_list.dart';
import 'job_seeker/application_add_update.dart';

class AppRouter {
  static Route generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case ApplicationList.route:
        return MaterialPageRoute(
          builder: (context) => ApplicationList(),
        );
        break;
      case ApplicationDetails.route:
        Application application = routeSettings.arguments;
        return MaterialPageRoute(
          builder: (context) => ApplicationDetails(
            application: application,
          ),
        );
        break;
      case AddUpdateApplication.route:
        ApplicationArgument args = routeSettings.arguments;
        return MaterialPageRoute(
          builder: (context) => AddUpdateApplication(
            args: args,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => ApplicationList(),
        );
    }
  }
}

class ApplicationArgument {
  final Application application;
  final bool edit;
  ApplicationArgument({this.application, this.edit});
}
