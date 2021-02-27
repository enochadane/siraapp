import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final bool _isRemoved = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Dashboard'),
            elevation: 1.0,
          ),
          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //     (BuildContext context, int index) {
          //       return Container(
          //         height: 50.0,
          //         width: MediaQuery.of(context).size.width,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(12.5),
          //           color: Theme.of(context).cardTheme.color,
          //         ),
          //         child: TextField(
          //           decoration: InputDecoration(
          //             fillColor: Theme.of(context).cardTheme.color,
          //             prefixIcon: Icon(
          //               Icons.search,
          //               size: 25.0,
          //               color: Theme.of(context).iconTheme.color,
          //             ),
          //             border: InputBorder.none,
          //           ),
          //           cursorColor: Theme.of(context).textTheme.bodyText1.color,
          //           cursorWidth: 0.8,
          //         ),
          //       );
          //     },
          //   ),
          // ),
          SliverFillRemaining(
            child: Container(
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                    elevation: 1.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('firstName'),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('lastName'),
                            ],
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: _isRemoved
                                    ? Text('Restore')
                                    : Text('Remove Roll'),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
