import 'package:app/blocs/job/job.dart';
import 'package:app/constants/colors.dart';
import 'package:app/models/job.dart';
import 'package:app/models/models.dart';
import 'package:app/presentation/screens/common/home_page.dart';
import 'package:app/presentation/screens/screens.dart';
import 'package:app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_edit_job.dart';

class JobDetails extends StatelessWidget {
  static const routeName = "/jobs/single";
  final Job selectedJob;
  final User user;

  const JobDetails({Key key, this.selectedJob, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var singleJob;
    handleDelete() {
      // context.read<JobBloc>().add(JobDelete(selectedJob));
      BlocProvider.of<JobBloc>(context).add(JobDelete(job: selectedJob));
      BlocProvider.of<JobBloc>(context).add(JobLoad(user: user));
      Navigator.of(context).pushNamed(HomePage.routeName);
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: kSurfaceWhite,
        body: BlocConsumer<JobBloc, JobState>(listener: (context, state) {
          if (state is JobOperationFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("There is an error")),
            );
          } else if (state is JobsLoadedSuccess) {
            // print("job loaded success");

            // singleJob = state.jobs
            //     .firstWhere((element) => selectedJob.id == element.id);
          }
        }, builder: (BuildContext context, JobState state) {
          if (state is JobsLoadedSuccess) {
            // singleJob = state.jobs
            //     .firstWhere((element) => selectedJob.id == element.id);
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.arrow_back_ios)),
                      (user.role == "EMPLOYER")
                          ? Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          CreateEditJobPage.routeName,
                                          arguments: selectedJob);
                                    },
                                    child: Icon(Icons.edit)),
                                SizedBox(
                                  width: 20.0,
                                ),
                                InkWell(
                                    onTap: () async {
                                      await _showDeleteWizard(
                                          context, selectedJob, handleDelete);
                                      Navigator.pop(context);
                                    },
                                    child: Icon(Icons.delete)),
                              ],
                            )
                          : Container()
                    ],
                  ),
                ),
                // CachedNetworkImage(
                //   height: 150.0,
                //   imageUrl:
                //       "https://cdn.pixabay.com/photo/2015/10/31/12/54/google-1015751_960_720.png",
                //   progressIndicatorBuilder: (context, url, downloadProgress) =>
                //       CircularProgressIndicator(value: downloadProgress.progress),
                //   errorWidget: (context, url, error) => Icon(Icons.error),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    selectedJob.name,
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Card(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Description",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                        SizedBox(height: 20),
                        Text(
                          selectedJob.description,
                        ),
                      ],
                    ),
                  )),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Card(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Other Information",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                        SizedBox(height: 20),
                        Text(
                          selectedJob.otherInfo,
                          // style: TextStyle(fontSize: 18.0, color: kGrayText),
                        ),
                      ],
                    ),
                  )),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ListTile(
                  leading: Text("Posted On",
                      style: TextStyle(
                        fontSize: 18.0,
                      )),
                  trailing: Text((DateTime.now()
                              .difference(selectedJob.datePublished)
                              .inDays) <
                          1
                      ? "${DateTime.now().difference(selectedJob.datePublished).inHours} day ago"
                      : "${DateTime.now().difference(selectedJob.datePublished).inDays} day ago"),
                ),

                SizedBox(
                  height: 10.0,
                ),
                ListTile(
                  leading: Text("Deadline On",
                      style: TextStyle(
                        fontSize: 18.0,
                      )),
                  trailing: Text((DateTime.now()
                              .difference(selectedJob.datePublished)
                              .inDays) <
                          1
                      ? "in ${DateTime.now().difference(selectedJob.deadline).inHours} days"
                      : "in ${DateTime.now().difference(selectedJob.deadline).inDays} days"),
                ),

                SizedBox(
                  height: 20.0,
                ),
                (user.role != "EMPLOYER")
                    ? (user.role == "SEEKER")
                        ? Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: RaisedButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 5.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      AddUpdateApplication.route,
                                      arguments: ApplicationArgument(
                                          edit: false, job: this.selectedJob));
                                },
                                color: kBrown400,
                                textColor: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 10.0),
                                  child: Text("Apply",
                                      style: TextStyle(fontSize: 18.0)),
                                )),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: RaisedButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 5.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(SignUpPage.routeName);
                                },
                                color: kBrown400,
                                textColor: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 10.0),
                                  child: Text("Register To Apply",
                                      style: TextStyle(fontSize: 18.0)),
                                )),
                          )
                    : Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RaisedButton(
                                color: kBrown400,
                                textColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 20.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onPressed: () => Navigator.of(context)
                                    .pushNamed(ApplicationList.route,
                                        arguments: ApplicationArgument(
                                          job: this.selectedJob,
                                          user: this.user,
                                        )),
                                child: Text('View Applications'),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Future<void> _showDeleteWizard(
      BuildContext context, Job selectedJob, Function handleDelete) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Do you want to delete?',
            style: TextStyle(color: Colors.redAccent),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Would you like to delete the job?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                  textStyle: TextStyle(color: Colors.grey)),
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              width: 5,
            ),
            TextButton(
                style: TextButton.styleFrom(
                    textStyle: TextStyle(color: Colors.redAccent)),
                child: Text('Delete'),
                onPressed: handleDelete),
          ],
        );
      },
    );
  }
}
