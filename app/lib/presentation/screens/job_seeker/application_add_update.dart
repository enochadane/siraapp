import 'package:app/blocs/application/application.dart';
import 'package:app/blocs/authentication/authentication.dart';
import 'package:app/data_provider/auth_data.dart';
import 'package:app/models/models.dart';
import 'package:app/presentation/screens/common/application_list.dart';
import 'package:app/presentation/screens/common/home_page.dart';
import 'package:app/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes.dart';

class AddUpdateApplication extends StatefulWidget {
  static const route = 'applicationAddUpdate';
  final ApplicationArgument args;
  // final Job job;
  // final User user;

  AddUpdateApplication({Key key, this.args})
      : super(key: key);

  @override
  _AddUpdateApplicationState createState() => _AddUpdateApplicationState();
}

class _AddUpdateApplicationState extends State<AddUpdateApplication> {
  final _messageController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _application = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.args.edit ? "Edit Application" : "Apply"}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue:
                      widget.args.edit ? widget.args.application.firstName : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter First Name';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    focusColor: Color(0xff4064f3),
                    labelStyle: TextStyle(
                      color: Color(0xff4064f3),
                    ),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Color(0xfff3f3f4),
                  ),
                  onSaved: (value) {
                    setState(() {
                      this._application['firstName'] = value;
                    });
                  },
                ),
                TextFormField(
                  initialValue:
                      widget.args.edit ? widget.args.application.lastName : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Last Name';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    focusColor: Color(0xff4064f3),
                    labelStyle: TextStyle(
                      color: Color(0xff4064f3),
                    ),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Color(0xfff3f3f4),
                  ),
                  onSaved: (value) {
                    this._application['lastName'] = value;
                  },
                ),
                TextFormField(
                  initialValue:
                      widget.args.edit ? widget.args.application.phone : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Phone';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    focusColor: Color(0xff4064f3),
                    labelStyle: TextStyle(
                      color: Color(0xff4064f3),
                    ),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Color(0xfff3f3f4),
                  ),
                  onSaved: (value) {
                    setState(() {
                      this._application['phone'] = value;
                    });
                  },
                ),
                TextFormField(
                  initialValue:
                      widget.args.edit ? widget.args.application.email : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Email';
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
                  onSaved: (value) {
                    setState(() {
                      this._application['email'] = value;
                    });
                  },
                ),
                TextFormField(
                  initialValue:
                      widget.args.edit ? widget.args.application.message : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Message';
                    }
                    return null;
                  },
                  maxLines: 8,
                  minLines: 1,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Message',
                    focusColor: Color(0xff4064f3),
                    labelStyle: TextStyle(
                      color: Color(0xff4064f3),
                    ),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Color(0xfff3f3f4),
                  ),
                  onSaved: (value) {
                    setState(() {
                      this._application['message'] = value;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          final form = _formKey.currentState;
                          if (form.validate()) {
                            if (state is AuthenticationAuthenticated) {
                              form.save();
                              final ApplicationEvent event = widget.args.edit
                                  ? ApplicationUpdate(
                                      Application(
                                        id: widget.args.application.id,
                                        firstName:
                                            this._application['firstName'],
                                        lastName: this._application['lastName'],
                                        phone: this._application['phone'],
                                        email: this._application['email'],
                                        message: this._application['message'],
                                      ),
                                    )
                                  : ApplicationCreate(
                                      Application(
                                        applicantId: state.user.id,
                                        companyId: widget.args.job.companyId,
                                        jobId: widget.args.job.id,
                                        firstName:
                                            this._application['firstName'],
                                        lastName: this._application['lastName'],
                                        phone: this._application['phone'],
                                        email: this._application['email'],
                                        message: this._application['message'],
                                      ),
                                    );
                              BlocProvider.of<ApplicationBloc>(context)
                                  .add(event);
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  HomePage.routeName, (route) => false);
                            }
                          }
                        },
                        child: Text('Submit'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
