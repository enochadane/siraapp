import "dart:async";
import 'package:app/data_provider/auth_data.dart';
import 'package:app/models/user.dart';
import 'package:meta/meta.dart';

enum AuthenticationStatus { unKnown, authenticated, unauthenticated }

class AuthenticationRepository {
  final AuthenticationDataProvider authenticationDataProvider;

  AuthenticationRepository({@required this.authenticationDataProvider});

  Future<User> logIn({
    @required String email,
    @required String password,
  }) async {
    return await authenticationDataProvider.signInWithEmailAndPassword(email, password);
  }

  Future<User> getCurrentUser() async {
    return await authenticationDataProvider.getCurrentUser();
  }

  void logOut() {
    authenticationDataProvider.signOut();
  }
}
