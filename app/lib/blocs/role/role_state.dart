import 'package:app/models/role.dart';
import 'package:equatable/equatable.dart';

class RoleState extends Equatable {
  const RoleState();

  @override
  List<Object> get props => [];
}

class RoleLoading extends RoleState {}

class RoleLoadSuccess extends RoleState {
  final List<Role> roles;

  RoleLoadSuccess([this.roles = const []]);

  @override
  List<Object> get props => [roles];
}

class RoleOperationFailure extends RoleState{}
