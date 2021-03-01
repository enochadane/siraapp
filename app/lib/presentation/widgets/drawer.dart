import 'package:app/blocs/authentication/authentication.dart';
import 'package:app/models/job.dart';
import 'package:app/models/user.dart';
import 'package:app/presentation/screens/common/common.dart';
import 'package:app/presentation/screens/common/user_edit.dart';
import 'package:app/repositories/authentication_repository.dart';
import 'package:app/routes.dart';
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
                    title: (state.user.role == "SEEKER")? Text('My Applications'): Container(),
                    onTap: () {
                      Navigator.of(context).pushNamed(ApplicationList.route,
                          arguments: ApplicationArgument(
                            user: state.user,
                          ));
                    },
                  );
                }
              },
            ),
            ListTile(
              title: Text('Edit Account'),
              onTap: () {
                Navigator.of(context).pushNamed(UpdateUser.routeName);
              },
            ),
            ListTile(
              title: Text(
                'Remove Account',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text('Close'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
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
