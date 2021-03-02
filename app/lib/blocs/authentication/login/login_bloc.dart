import 'package:app/exceptions/exception.dart';
import 'package:app/repositories/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication.dart';
import 'login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc authenticationBloc;
  final AuthenticationRepository authenticationRepository;

  LoginBloc(AuthenticationBloc authenticationBloc,
      AuthenticationRepository authenticationRepository)
      : assert(authenticationBloc != null),
        assert(authenticationRepository != null),
        authenticationBloc = authenticationBloc,
        authenticationRepository = authenticationRepository,
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginInWithEmailButtonPressed) {
      yield* _mapLoginWithEmailToState(event);
    }
  }

  Stream<LoginState> _mapLoginWithEmailToState(
      LoginInWithEmailButtonPressed event) async* {
    yield LoginLoading();

    try {
      final user = await authenticationRepository.logIn(
          email: event.email, password: event.password);
      if (user != null) {
        authenticationBloc.add(UserLoggedIn(user: user));
        yield LoginSuccess();
        // yield LoginInitial();
      } else {
        yield LoginFailure(error: 'Something very weird just happened');
      }
    } on AuthenticationException catch (e) {
      yield LoginFailure(error: e.message);
    } catch (err) {
      yield LoginFailure(error: err.message ?? 'An unknown error occured');
    }
  }
}
