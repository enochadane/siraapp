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
class HomePage extends StatelessWidget {
  static final String routeName = "/";
  final User user;
  HomePage({@required this.user});

  @override
  Widget build(BuildContext context) {
    context.read<JobBloc>().add(JobLoad(user: user));

    return Scaffold(
       endDrawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Job List"),
      ),
      body: Container(
        child: BlocConsumer<JobBloc, JobState>(listener: (context, state) {
          if (state is JobOperationFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("There is an error")),
            );
          } else if (state is JobLoading) {
            return CircularProgressIndicator();
          } else if (state is JobLoading ||
              state is JobsLoadedSuccess && state.jobs.length == 0) {
            return Text("No Jobs Are Available");
          }
        }, builder: (context, state) {
          if (state is JobLoading) {
            return CircularProgressIndicator();
          } else if (state is JobsLoadedSuccess) {
            if (state.jobs.length > 0) {
              return ListView.builder(
                  itemCount: state.jobs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, JobDetails.routeName,
                            arguments: SingleJobDetailArguments(
                                selectedJob: state.jobs[index], user: user));
                      },
                      child: JobRow(
                        job: state.jobs[index],
                      ),
                    );
                  });
            }
            return Card(
                child: Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Text("No Jobs Are Available",
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            ));
          }
          return Container();
        }),
      ),
      floatingActionButton: (user.role == "EMPLOYER")
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
