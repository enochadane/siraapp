import 'package:app/blocs/authentication/user/user.dart';
import 'package:app/blocs/role/role.dart';
import 'package:app/blocs/role/role_bloc.dart';
import 'package:app/blocs/role/role_state.dart';
import 'package:app/models/models.dart';
import 'package:app/models/role.dart';
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
  @override
  Widget build(BuildContext context) {
    handleUserDelete(User selectedUser) {
      final UserEvent event = UserDelete(selectedUser);
      BlocProvider.of<UserBloc>(context).add(event);
    }

    handleRoleDelete(Role selectedRole) {
      final RoleEvent event = RoleDelete(selectedRole);
      BlocProvider.of<RoleBloc>(context).add(event);
    }

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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                state.users[index].username,
                                                style:
                                                    TextStyle(fontSize: 18.0),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                state.users[index].email,
                                                style:
                                                    TextStyle(fontSize: 14.0),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(state.users[index].role),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  await _showUserDeleteWizard(
                                                      context,
                                                      state.users[index],
                                                      handleUserDelete);
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              ),
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
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        state.roles[index].name,
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          await _showRoleDeleteWizard(
                                              context,
                                              state.roles[index],
                                              handleRoleDelete);
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
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

  Future<void> _showRoleDeleteWizard(BuildContext context, Role selectedRole,
      Function handleRoleDelete) async {
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
                Text('Would you like to delete the role?'),
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
                onPressed: () {
                  handleRoleDelete(selectedRole);
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  Future<void> _showUserDeleteWizard(BuildContext context, User selectedUser,
      Function handleUserDelete) async {
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
                Text('Would you like to delete the role?'),
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
                onPressed: () {
                  handleUserDelete(selectedUser);
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }
}
