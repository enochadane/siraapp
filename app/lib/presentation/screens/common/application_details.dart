import 'package:app/blocs/application/application.dart';
import 'package:app/blocs/authentication/authentication.dart';
import 'package:app/models/application.dart';
import 'package:app/models/user.dart';
import 'package:app/presentation/screens/job_seeker/application_add_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes.dart';
import 'application_list.dart';

class ApplicationDetails extends StatelessWidget {
  static const route = 'applicationDetails';
  final Application application;
  final User user;

  ApplicationDetails({@required this.application, this.user});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApplicationBloc, ApplicationState>(
      listener: (context, state) {
        if (state is ApplicationOperationFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text("There is an error")),
          );
        } else if (state is ApplicationLoading) {
          return CircularProgressIndicator();
        } else if (state is ApplicationLoading ||
            state is ApplicationLoadSuccess && state.applications.length == 0) {
          return Text("No Applications to view");
        }
      },
      builder: (context, state) {
        return BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is AuthenticationAuthenticated) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Applications'),
                  actions: [
                    (state.user.role == "SEEKER") ? Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => Navigator.of(context).pushNamed(
                            AddUpdateApplication.route,
                            arguments: ApplicationArgument(
                                application: this.application, edit: true),
                          ),
                        ),
                        SizedBox(
                          width: 32,
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            BlocProvider.of<ApplicationBloc>(context)
                                .add(ApplicationDelete(this.application));
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                ApplicationList.route, (route) => false);
                          },
                        ),
                      ],
                    ) : Container()
                  ],
                ),
                body: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Card(
                          margin: EdgeInsets.all(10.0),
                          elevation: 1.0,
                          child: Container(
                            height: 30.0,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${this.application.firstName}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          'Applicant Data',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.all(10.0),
                          elevation: 1.0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: [
                                    SizedBox(height: 20.0),
                                    Text(
                                      'Full Name: ${this.application.firstName} ${this.application.lastName}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ],
                                ),
                                // Text('Major : '),
                                SizedBox(height: 15.0),
                                Text(
                                  'Phone: ${this.application.phone}',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                                SizedBox(height: 15.0),
                                Text(
                                  'Email: ${this.application.email}',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                                SizedBox(height: 15.0),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Message From Applicant',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          height: 60.0,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            margin: EdgeInsets.all(10.0),
                            elevation: 1.0,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                '${this.application.message}',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        (state.user.role == "EMPLOYER")? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            TextButton(
                              child: Text('Decline'),
                              onPressed: () {},
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text('Approve'),
                            )
                          ],
                        ): Container()
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        );
      },
    );
  }
}
