import 'package:app/data_provider/data_provider.dart';
import 'package:app/models/models.dart';
import 'package:flutter/cupertino.dart';

class UserRepository {
  final UserDataProvider dataProvider;

  UserRepository({@required this.dataProvider}) : assert(dataProvider != null);

  Future<User> createUser(User user) async {
    return await dataProvider.createUser(user);
  }

  Future<User> updateUserRole(String userId, String roleId) async {
    return await dataProvider.updateUserRole(userId, roleId);
  }

  Future<List<User>> getUsers() async {
    return await dataProvider.getUsers();
  }

  Future<void> updateUser(User user) async {
    await dataProvider.updateUser(user);
  }

  Future<void> deleteUser(String id) async {
    await dataProvider.deleteUser(id);
  }
}
