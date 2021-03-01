import 'package:app/models/job.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class JobRow extends StatelessWidget {
  final Job job;
  static final DateFormat formatter = DateFormat.MMMEd();

  const JobRow({Key key, @required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/job.png', scale: 1.0, height: 100.0, width: 80.0,),
            SizedBox(
              width: 30.0,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                height: 150.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          job.name,
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                            "${DateTime.now().difference(job.datePublished).inDays} days ago")
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text("company"),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Text(
                            "Close after ${DateTime.now().difference(job.datePublished).inDays} days")
                      ],
                    ),
                  ],
                ),
              ),
            )

            // Container(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceAround,
            //         children: [
            //           // Image.network(
            //           //   "src",
            //           //   width: 100,
            //           //   height: 100,
            //           // ),

            //           Expanded(
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [Text(job.name), Text(job.jobPosition)],
            //             ),
            //           ),
            //           Spacer(),
            //           // Text( formatter.format(job.datePublished).toString())
            //           Text(
            //               "${DateTime.now().difference(job.datePublished).inDays} days ago")
            //         ],
            //       ),
            //       Row(
            //         children: [
            //           Text(
            //               "Deadline after ${DateTime.now().difference(job.datePublished).inDays} days")
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
