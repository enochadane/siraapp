import 'package:app/data_provider/data_provider.dart';
import 'package:app/models/role.dart';
import 'package:flutter/cupertino.dart';

class RoleRepository {
  final RoleDataProvider dataProvider;

  RoleRepository({@required this.dataProvider}) : assert(dataProvider != null);

  Future<Role> createRole(Role role) async {
    return await dataProvider.createRole(role);
  }

  Future<List<Role>> getRoles() async {
    return await dataProvider.getRoles();
  }

  Future<void> deleteRole(String id) async {
    await dataProvider.deleteRole(id);
  }
}
