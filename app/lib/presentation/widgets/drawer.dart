import 'package:app/blocs/authentication/authentication.dart';
import 'package:app/models/job.dart';
import 'package:app/models/user.dart';
import 'package:app/presentation/screens/common/common.dart';
import 'package:app/presentation/screens/common/user_edit.dart';
import 'package:app/repositories/authentication_repository.dart';
import 'package:app/routes.dart';
import 'package:app/blocs/authentication/authBloc.dart';
import 'package:app/blocs/authentication/authentication.dart';
import 'package:app/presentation/screens/common/common.dart';
import 'package:app/presentation/screens/common/user_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDrawer extends StatelessWidget {
  final User user;
  const MyDrawer({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 32.0,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            createDrawerHeader(),
            BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is AuthenticationAuthenticated) {
                  return ListTile(
                    title: (state.user.role == "SEEKER")
                        ? Text('My Applications')
                        : Container(),
                    onTap: () {
                      Navigator.of(context).pushNamed(ApplicationList.route,
                          arguments: ApplicationArgument(
                            user: state.user,
                          ));
                    },
                  );
                } else {
                  return null;
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.edit_outlined),
              title: Text(
                'Edit Account',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(UpdateUser.routeName);
              },
            ),
            ListTile(
              focusColor: Colors.blue,
              hoverColor: Colors.blue,
              leading: Icon(Icons.delete_outline),
              title: Text(
                'Remove Account',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              onTap: () {
                // RepositoryProvider.of<AuthenticationRepository>(context)
                // .logOut();
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(UserLoggedOut());
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginPage.routeName, (route) => false);
              },
            ),
            Spacer(flex: 1),
            ListTile(
              leading: Icon(Icons.close_outlined),
              title: Text(
                'Close',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget createDrawerHeader() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is AuthenticationAuthenticated) {
        return UserAccountsDrawerHeader(
          accountEmail: Text(state.user.email),
          accountName: Text(state.user.username),
          onDetailsPressed: () => {},
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('assets/images/avatar.jpeg'),
          ),
          margin: EdgeInsets.zero,
          // padding: EdgeInsets.zero,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/avatar.jpeg'))),
        );
      }
      return UserAccountsDrawerHeader(
        accountEmail: Text("nathaniel.awel@gmail.com"),
        accountName: Text("Nathaniel Hussein"),
        onDetailsPressed: () => {},
        currentAccountPicture: CircleAvatar(
          backgroundImage: AssetImage('assets/images/avatar.jpeg'),
        ),
        margin: EdgeInsets.zero,
        // padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/avatar.jpeg'))),
      );
    });
  }
}
