import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterUser extends RegisterEvent {
  final String username;
  final String email;
  final String password;
  // ignore: non_constant_identifier_names
  final String role_id;

  // ignore: non_constant_identifier_names
  RegisterUser({@required this.username, @required this.email, @required this.password, @required this.role_id});

  @override
  List<Object> get props => [username, email, password, role_id];
}
