import 'package:app/blocs/authentication/user/user.dart';
import 'package:app/constants/colors.dart';
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
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      labelText: "Username",
                      labelStyle: TextStyle(color: kBrown300),
                      hintText: 'Enter of Username',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kBrown300, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kBrown300, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    onChanged: (value) {
                      setState(
                        () {
                          this._user['username'] = value;
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: this._user['email'],
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter User Email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      labelText: "Email",
                      labelStyle: TextStyle(color: kBrown300),
                      hintText: 'Enter of Email',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kBrown300, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kBrown300, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    onChanged: (value) {
                      setState(
                        () {
                          this._user['email'] = value;
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    // initialValue: ,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter User Password';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      labelText: "Password",
                      labelStyle: TextStyle(color: kBrown300),
                      hintText: 'Enter of Password',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kBrown300, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kBrown300, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    onChanged: (value) {
                      setState(
                        () {
                          this._user['password'] = value;
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 20.0),
                      color: kBrown400,
                      textColor: Colors.white,
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
