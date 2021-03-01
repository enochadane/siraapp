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
  TextEditingController editingController = TextEditingController();

  var jobItems = List<Job>();

  void filterSearchResults(String query, List<Job> jobs) {
    List<Job> dummySearchList = List<Job>();
    dummySearchList.addAll(jobs);

    if (query.isNotEmpty) {
      List<Job> dummyListData = List<Job>();
      dummySearchList.forEach((item) {
        if (item.name.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        jobItems.clear();
        jobItems.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        jobItems.clear();
        jobItems.addAll(jobs);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<JobBloc, JobState>(listener: (context, state) {
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
        jobItems.addAll(state.jobs);

        return Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            title: Text("Job List"),
          ),
          body:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value, jobItems);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
              ),
            ),
            Container(
              child: (state.jobs.length > 0)
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: jobItems.length,
                      // itemCount: state.jobs.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, JobDetails.routeName,
                                arguments: SingleJobDetailArguments(
                                    // selectedJob: state.jobs[index],
                                    selectedJob: jobItems[index],
                                    user: widget.user));
                          },
                          child: JobRow(
                            // job: state.jobs[index],
                            job: jobItems[index],
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
            )
          ]),
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
      return Container();
    });
  }
}

class SingleJobDetailArguments {
  final Job selectedJob;
  final User user;

  SingleJobDetailArguments({this.selectedJob, @required this.user});
}
