import 'package:app/presentation/screens/common/common.dart';
import 'package:app/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);

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
            ListTile(
              title: Text(
                'Logout',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onTap: () {
                RepositoryProvider.of<AuthenticationRepository>(context)
                    .logOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginPage.routeName, (route) => false);
              },
            ),
            ListTile(
              title: Text('Close'),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget createDrawerHeader() {
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
  }
}