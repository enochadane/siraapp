import 'package:app/models/models.dart';
import 'package:app/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserLoad extends UserEvent {
  @override
  List<Object> get props => [];
}

class UserCreate extends UserEvent {
  final User user;
  const UserCreate(this.user);

  @override
  List<Object> get props => [user];
}

class UserRoleUpdate extends UserEvent {
  final String userId;
  final String roleId;
  const UserRoleUpdate({this.userId, this.roleId});

  @override
  List<Object> get props => [this.userId, this.roleId];
}

class UserDelete extends UserEvent {
  final User user;
  const UserDelete(this.user);

  @override
  List<Object> get props => [user];
}
