import 'package:app/blocs/authentication/user/user.dart';
import 'package:app/blocs/role/role.dart';
import 'package:app/blocs/role/role_bloc.dart';
import 'package:app/blocs/role/role_state.dart';
import 'package:app/presentation/screens/admin/create_role.dart';
import 'package:app/presentation/screens/admin/role_change.dart';
import 'package:app/presentation/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final bool _isRemoved = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            title: Text('DashBoard'),
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text('Users'),
                ),
                Tab(
                  child: Text('Roles'),
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is UserLoadSuccess) {
                    return CustomScrollView(
                      slivers: <Widget>[
                        SliverFillRemaining(
                          child: Container(
                            height: 100.0,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              itemCount: state.users.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        ChangeRole.routeName,
                                        arguments: state.users[index]);
                                  },
                                  child: Card(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                    elevation: 1.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(state.users[index].username),
                                              SizedBox(
                                                width: 20.0,
                                              ),
                                              Text(state.users[index].email),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(state.users[index].role),
                                              TextButton(
                                                onPressed: () {},
                                                child: _isRemoved
                                                    ? Row(
                                                        children: [
                                                          Icon(Icons.lock_open),
                                                          Text('Release'),
                                                        ],
                                                      )
                                                    : Row(
                                                        children: [
                                                          Icon(
                                                            Icons.lock,
                                                            color: Colors.red,
                                                            size: 16.0,
                                                          ),
                                                          Text(
                                                            'Suspend',
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return Container(
                    child: Text("Loading"),
                  );
                }),
            BlocConsumer<RoleBloc, RoleState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is RoleLoadSuccess) {
                    return Scaffold(
                      body: ListView.builder(
                        itemCount: state.roles.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 1.0,
                            margin: EdgeInsets.all(10.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(CreateRole.routeName);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      state.roles[index].name,
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.remove_circle,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        final RoleEvent event =
                                            RoleDelete(state.roles[index]);
                                        BlocProvider.of<RoleBloc>(context)
                                            .add(event);
                                        // Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      floatingActionButton: FloatingActionButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(CreateRole.routeName);
                        },
                        child: Icon(Icons.add),
                      ),
                    );
                  } else {
                    return Text("Loading");
                  }
                }),
          ]),
        ));
  }
}
