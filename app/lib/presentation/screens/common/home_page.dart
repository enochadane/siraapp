import 'package:app/blocs/job/job.dart';
import 'package:app/models/job.dart';
import 'package:app/models/user.dart';
import 'package:app/presentation/screens/employer/create_edit_job.dart';
import 'package:app/presentation/screens/employer/job_details.dart';
import 'package:app/presentation/widgets/drawer.dart';
import 'package:app/presentation/widgets/job/job_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  static const String routeName = "/";
  final User user;

  HomePage({@required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            drawer: MyDrawer(
              user: widget.user,
            ),
            appBar: AppBar(
              title: Text("Job List"),
            ),
          body: BlocConsumer<JobBloc, JobState>(listener: (context, state) {
        if (state is JobOperationFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text("There is an error")),
          );
          // _scaffoldKey.currentState.showSnackBar(
          //   SnackBar(content: Text('There is an Error')),
          // );
          BlocProvider.of<JobBloc>(context).add(JobLoad(user: widget.user));
        }
        if (state is JobCreate) {
          BlocProvider.of<JobBloc>(context).add(JobLoad(user: widget.user));
        }
      }, builder: (context, state) {
        if (state is JobsLoadedSuccess) {
            return Container(
              child: (state.jobs.length > 0)
                  ? ListView.builder(
                      itemCount: state.jobs.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, JobDetails.routeName,
                                arguments: SingleJobDetailArguments(
                                    selectedJob: state.jobs[index],
                                    user: widget.user));
                          },
                          child: JobRow(
                            job: state.jobs[index],
                          ),
                        );
                      })
                  : Card(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        child: Text("No Jobs Are Available",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                      ),
                    ),
            );
            
          // );
        }
        return Container();
      }),
      floatingActionButton: (widget.user.role == "EMPLOYER")
                ? FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      Navigator.pushNamed(context, CreateEditJobPage.routeName);
                    },
                  )
                : null,
    );
  }
}

class SingleJobDetailArguments {
  final Job selectedJob;
  final User user;

  SingleJobDetailArguments({this.selectedJob, @required this.user});
}
