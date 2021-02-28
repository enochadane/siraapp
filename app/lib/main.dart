import 'package:app/blocs/authentication/authBloc.dart';
import 'package:app/blocs/authentication/authentication.dart';
import 'package:app/blocs/authentication/login/login.dart';
import 'package:app/data_provider/auth_data.dart';
import 'package:app/presentation/screens/common/login_screen.dart';
import 'package:app/repositories/authentication_repository.dart';
import 'package:app/repositories/repository.dart';
import 'package:app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository(
          authenticationDataProvider: AuthenticationDataProvider());

  runApp(App(
    authenticationRepository: authenticationRepository,
  ));
}

class App extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;

  const App({Key key, this.authenticationRepository})
      : assert(authenticationRepository != null);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: this.authenticationRepository)
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationBloc>(
                create: (context) =>
                    AuthenticationBloc(this.authenticationRepository)..add(AppLoaded())),
            BlocProvider<LoginBloc>(
                create: (context) => LoginBloc(
                    authenticationBloc:
                        AuthenticationBloc(authenticationRepository),
                    authenticationRepository: this.authenticationRepository)),
            //  BlocProvider<AuthenticationBloc>(
            // create: (context) => AuthenticationBloc(this.authenticationRepository)),
          ],
          child: MaterialApp(
            title: 'Job Portal',
            debugShowCheckedModeBanner: false,
            initialRoute: "/register",
            onGenerateRoute: MyPageRouter.onGenerateRoute,
          ),
        ));
  }
}
