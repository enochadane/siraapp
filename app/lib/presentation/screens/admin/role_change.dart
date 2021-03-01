import 'package:app/blocs/authentication/user/user_bloc.dart';
import 'package:app/blocs/authentication/user/user_event.dart';
import 'package:app/blocs/role/role_bloc.dart';
import 'package:app/blocs/role/role_event.dart';
import 'package:app/blocs/role/role_state.dart';
import 'package:app/constants/colors.dart';
import 'package:app/models/models.dart';
import 'package:app/models/role.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeRole extends StatefulWidget {
  static const String routeName = '/changerole';
  final User user;

  const ChangeRole({Key key, this.user}) : super(key: key);

  @override
  _ChangeRoleState createState() => _ChangeRoleState();
}

class _ChangeRoleState extends State<ChangeRole> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController roleController = TextEditingController();
  String role;
  Role selectedRole;

  buildRoleDropDown(List<Role> roles) {
    print("role is ${widget.user.toJson()}");
    if (selectedRole == null) {
      selectedRole = roles.firstWhere(
          (element) => element.name == widget.user.role,
          orElse: () => Role(id: "23092039203", name: "ADMIN"));
    }
    return Container(
      child: ListTile(
        leading: Text(
          "Select Role",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        trailing: DropdownButton(
          value: this.selectedRole,
          items: roles.map((role) {
            return DropdownMenuItem(
              child: Text(role.name),
              value: role,
            );
          }).toList(),
          onChanged: (Role selected) {
            setState(() {
              this.selectedRole = selected;
            });
          },
        ),
      ),
    );
  }
  handleDelete() {
      // context.read<RoleBloc>().add(JobDelete(selectedJob));
      // BlocProvider.of<JobBloc>(context).add(JobDelete(selectedJob));
      Navigator.of(context).pop();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Role'),
      ),
      body: BlocConsumer<RoleBloc, RoleState>(
          builder: (context, state) {
            if (state is RoleLoadSuccess) {
              return Form(
                  key: _formKey,
                  child: Column(children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Text(
                            "Username: ",
                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.user.username,
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Text(
                            "Email: ",
                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.user.username,
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    buildRoleDropDown(state.roles),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton.icon(
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        color: kBrown400,
                        onPressed: () {
                          final form = _formKey.currentState;
                          if (form.validate()) {
                            form.save();

                            BlocProvider.of<UserBloc>(context).add(
                                UserRoleUpdate(
                                    userId: widget.user.id,
                                    roleId: selectedRole.id));
                            Navigator.of(context)
                                .pushNamedAndRemoveUntil('/', (route) => false);
                          }
                        },
                        icon: Icon(Icons.save, color: Colors.white,),
                        label: Text('SAVE', style: TextStyle(color: Colors.white),),
                      ),
                    )
                  ]));
            } else {
              return Text("Error");
            }
          },
          listener: (context, state) {}),
    );
  }


}
