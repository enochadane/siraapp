import 'package:app/models/role.dart';
import 'package:equatable/equatable.dart';

abstract class RoleEvent extends Equatable {
  const RoleEvent();
}

class RoleLoad extends RoleEvent {
  @override
  List<Object> get props => [];
}

class RoleCreate extends RoleEvent {
  final Role role;
  const RoleCreate(this.role);

  @override
  List<Object> get props => [role];
}

class RoleDelete extends RoleEvent {
  final Role role;
  const RoleDelete(this.role);

  @override
  List<Object> get props => [role];
}
