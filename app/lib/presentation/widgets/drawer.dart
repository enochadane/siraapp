import 'package:app/blocs/authentication/authentication.dart';
import 'package:app/models/user.dart';
import 'package:app/presentation/screens/common/common.dart';
import 'package:app/presentation/screens/common/user_edit.dart';
import 'package:app/routes.dart';
import 'package:app/blocs/authentication/authBloc.dart';
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
            (user?.role == "SEEKER")
                ? ListTile(
                    leading: Icon(Icons.note_outlined),
                    title: Text(
                      'My Applications',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(ApplicationList.route,
                          arguments: ApplicationArgument(
                            user: user,
                          ));
                    },
                  )
                : SizedBox(),
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
              leading: Icon(Icons.logout),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              onTap: () {
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
