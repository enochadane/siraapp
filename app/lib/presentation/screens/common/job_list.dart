import 'package:app/blocs/job/job.dart';
import 'package:app/models/job.dart';
import 'package:app/presentation/screens/employer/create_edit_job.dart';
import 'package:app/presentation/screens/employer/single_job.dart';
import 'package:app/presentation/widgets/job/job_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class JobListPage extends StatelessWidget {
  static final String routeName = "/jobs";
  final String userType;
  JobListPage({@required this.userType});

  @override
  Widget build(BuildContext context) {
    context.read<JobBloc>().add(JobLoad(userType: userType, companyId: "60285807c314797e15dd419f"));

    return Scaffold(
      appBar: AppBar(
        title: Text("Job List"),
      ),
      body: Container(
        child: BlocConsumer<JobBloc, JobState>(
          listener: (context, state) {
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
        }, 
        builder: (context, state) {
          if (state is JobLoading) {
            return CircularProgressIndicator();
          } else if (state is JobsLoadedSuccess) {

            if (state.jobs.length > 0) {
              return ListView.builder(
                  itemCount: state.jobs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, SingleJobPage.routeName,
                            arguments: SingleJobDetailArguments(
                                state.jobs[index], userType));
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
      floatingActionButton: (userType == "employer")
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
  final String userType;

  SingleJobDetailArguments(this.selectedJob, this.userType);
}
