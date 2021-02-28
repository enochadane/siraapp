import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterUser extends RegisterEvent {
  final String name;
  final String email;
  final String password;
  final String role_id;

  RegisterUser({this.name, @required this.email, @required this.password, @required this.role_id});

  @override
  List<Object> get props => [name, email, password];
}
