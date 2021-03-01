import 'package:app/blocs/authentication/authBloc.dart';
import 'package:app/blocs/authentication/authentication.dart';
import 'package:app/blocs/authentication/login/login.dart';
import 'package:app/blocs/authentication/register/register_bloc.dart';
import 'package:app/data_provider/auth_data.dart';
import 'package:app/repositories/authentication_repository.dart';
import 'package:app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'bloc_observer.dart';

class TokenData {
  static String token;
}

Future<String> getToken() async {
  final storage = new FlutterSecureStorage();
  var token = await storage.read(key: "jwt_token");
  return "'Bearer $token';";
}

void main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  TokenData.token = await getToken();
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository(
          authenticationDataProvider: AuthenticationDataProvider());
  runApp(App(
    authenticationRepository: authenticationRepository,
  ));
}

class App extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;

  const App({
    Key key,
    this.authenticationRepository,
  }) : assert(authenticationRepository != null);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: this.authenticationRepository),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationBloc>(
                create: (context) =>
                    AuthenticationBloc(this.authenticationRepository)
                      ..add(AppLoaded())),
            BlocProvider<LoginBloc>(
                create: (context) => LoginBloc(
                    authenticationBloc:
                        AuthenticationBloc(authenticationRepository),
                    authenticationRepository: this.authenticationRepository)),
            BlocProvider<RegisterBloc>(
                create: (context) => RegisterBloc(
                    authenticationBloc:
                        AuthenticationBloc(authenticationRepository),
                    authenticationRepository: this.authenticationRepository)),
          ],
          child: MaterialApp(
            title: 'Job Portal',
            debugShowCheckedModeBanner: false,
            initialRoute: "/",
            onGenerateRoute: MyPageRouter().onGenerateRoute,
            // home: AdminDashboard(),
          ),
        ));
  }
}
