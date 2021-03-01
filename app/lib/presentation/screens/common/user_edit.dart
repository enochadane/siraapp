import 'package:app/blocs/authentication/user/user.dart';
import 'package:app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateUser extends StatefulWidget {
  static const routeName = 'userUpdate';
  final User loggedInUser;

  const UpdateUser({Key key, this.loggedInUser}) : super(key: key);
  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _user = {};
  @override
  void initState() {
    super.initState();
    this._user['id'] = widget.loggedInUser.id;
    this._user['username'] = widget.loggedInUser.username;
    this._user['email'] = widget.loggedInUser.email;
    this._user['password'] = null;
    this._user['role'] = null;
  }

  void _showError(String error, context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(error),
      backgroundColor: Theme.of(context).errorColor,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Account'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: BlocConsumer<UserBloc, UserState>(listener: (context, state) {
            if (state is UserOperationFailure) {
              _showError("Something went wrong on updating", context);
            }
          }, builder: (context, state) {
            // if (state is UserLoadSuccess) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: this._user['username'],
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter User Name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'userName',
                      focusColor: Color(0xff4064f3),
                      labelStyle: TextStyle(
                        color: Color(0xff4064f3),
                      ),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xfff3f3f4),
                    ),
                    onChanged: (value) {
                      setState(
                        () {
                          this._user['username'] = value;
                        },
                      );
                    },
                  ),
                  TextFormField(
                    initialValue: this._user['email'],
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter User Email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      focusColor: Color(0xff4064f3),
                      labelStyle: TextStyle(
                        color: Color(0xff4064f3),
                      ),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xfff3f3f4),
                    ),
                    onChanged: (value) {
                      setState(
                        () {
                          this._user['email'] = value;
                        },
                      );
                    },
                  ),
                  TextFormField(
                    // initialValue: ,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter User Password';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      focusColor: Color(0xff4064f3),
                      labelStyle: TextStyle(
                        color: Color(0xff4064f3),
                      ),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xfff3f3f4),
                    ),
                    onChanged: (value) {
                      setState(
                        () {
                          this._user['password'] = value;
                        },
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        final form = _formKey.currentState;
                        if (form.validate()) {
                          form.save();
                          final event = UserUpdate(User(
                              id: this._user['id'],
                              username: this._user['username'],
                              email: this._user['email'],
                              password: this._user['password'],
                              role: null));
                          BlocProvider.of<UserBloc>(context).add(event);
                        }
                      },
                      child: Text('Update'),
                    ),
                  )
                ],
              ),
            );
            // }
            // return Container();
          }),
        ),
      ),
    );
  }
}
