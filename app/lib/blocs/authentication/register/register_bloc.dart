import 'package:app/blocs/authentication/register/register.dart';
import 'package:app/data_provider/auth_data.dart';
import 'package:app/exceptions/exception.dart';
import 'package:app/repositories/authentication_repository.dart';
import 'package:app/repositories/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationBloc authenticationBloc;
  final AuthenticationRepository authenticationRepository;

  RegisterBloc({this.authenticationBloc, this.authenticationRepository})
      : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
     if (event is RegisterUser) {
      yield* _mapSeekerRegisterWithEmailToState(event);
    }
  }

  Stream<RegisterState> _mapSeekerRegisterWithEmailToState(
      RegisterUser event) async* {
    yield RegisterLoading();

    try {
      final user = await authenticationRepository.register(
          email: event.email, password: event.password, role_id: event.role_id);
      if (user != null) {
        authenticationBloc.add(UserLoggedIn(user: user));
        yield RegisterSuccess();
        yield RegisterInitial();
      } else {
        yield RegisterFailure(error: 'Something very weird just happened');
      }
    } on AuthenticationException catch (e) {
      yield RegisterFailure(error: e.message);
    } catch (err) {
      yield RegisterFailure(error: err.message ?? 'An unknown error occured');
    }
  }

}
