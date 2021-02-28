import 'package:app/blocs/authentication/register/register.dart';
import 'package:app/exceptions/exception.dart';
import 'package:app/repositories/authentication_repository.dart';
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
      final bool isCreated = await authenticationRepository.register(
          username: event.username,
          email: event.email,
          password: event.password,
          role_id: event.role_id);
      print("logged in user $isCreated");

      if (isCreated) {
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
