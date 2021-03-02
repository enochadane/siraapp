import 'package:app/blocs/application/application.dart';
import 'package:app/presentation/screens/common/application_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes.dart';

class ApplicationList extends StatelessWidget {
  static const route = 'applications';

  final ApplicationArgument args;

  ApplicationList({Key key, this.args}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ApplicationLoad event =
        ApplicationLoad(job: args?.job, user: args?.user);
    BlocProvider.of<ApplicationBloc>(context).add(event);

    return Scaffold(
      appBar: AppBar(
        title: Text("Application Lists"),
      ),
      body: BlocBuilder<ApplicationBloc, ApplicationState>(
        builder: (_, state) {
          if (state is ApplicationOperationFailure) {
            return Text("Couldn't fetch applications");
          }

          if (state is ApplicationLoadSuccess) {
            final applications = state.applications;
            return applications.length > 0
                ? Container(
                    child: ListView.builder(
                      itemCount: applications.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                ApplicationDetails.route,
                                arguments: ApplicationArgument(
                                    application: applications[index],
                                    job: args.job,
                                    user: args.user));
                          },
                          child: ApplicationCard(
                            firstName: '${applications[index].firstName}',
                            lastName: '${applications[index].lastName}',
                            phone: '${applications[index].phone}',
                            email: '${applications[index].email}',
                            message: '${applications[index].message}',
                          ),
                        );
                      },
                    ),
                  )
                : Container(
                    child: ApplicationCard(
                    firstName: "No Application",
                    lastName: "Has Found",
                    phone: "",
                    email: "",
                    message: "For this Job",
                  ));
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Navigator.of(context).pushNamed(
      //     AddUpdateApplication.route,
      //     arguments: ApplicationArgument(edit: false),
      //   ),
      //   child: Icon(Icons.add),
      // ),
    );
  }
}

class ApplicationCard extends StatelessWidget {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String message;

  ApplicationCard(
      {this.id,
      this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      height: 120.0,
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 2.0,
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    '$firstName $lastName',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              Text(
                message,
                style: TextStyle(
                  fontSize: 17.0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(phone),
                  Text(email),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
