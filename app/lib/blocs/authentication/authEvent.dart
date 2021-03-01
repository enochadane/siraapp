import 'package:app/models/user.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  // const AuthenticationEvent();
    AuthenticationEvent([List props = const []]) : super();


  @override
  List<Object> get props => [];
}

// Fired just after the app is loaded
class AppLoaded extends AuthenticationEvent {}

// Fired just a user has successfully logged in
class UserLoggedIn extends AuthenticationEvent {
  final User user;

  UserLoggedIn({@required this.user}):super([user]);
  @override
  List<Object> get props => [user];
}

// Fired just after the user has logged out
class UserLoggedOut extends AuthenticationEvent {}
