import 'package:app/blocs/application/application.dart';
import 'package:app/blocs/authentication/authentication.dart';
import 'package:app/constants/colors.dart';
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

  AddUpdateApplication({Key key, this.args}) : super(key: key);

  @override
  _AddUpdateApplicationState createState() => _AddUpdateApplicationState();
}

class _AddUpdateApplicationState extends State<AddUpdateApplication> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _application = {};

  @override
  Widget build(BuildContext context) {
    print('${widget.args.job} from application update *********** ');
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
                    isCollapsed: true,
                    labelText: "First Name",
                    labelStyle: TextStyle(color: kBrown300),
                    hintText: 'First Name',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
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
                  onSaved: (value) {
                    setState(() {
                      this._application['firstName'] = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20.0,
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
                    isCollapsed: true,
                    labelText: "Last Name",
                    labelStyle: TextStyle(color: kBrown300),
                    hintText: 'Last Name',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
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
                  onSaved: (value) {
                    this._application['lastName'] = value;
                  },
                ),
                SizedBox(
                  height: 20.0,
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
                    isCollapsed: true,
                    labelText: "Phone",
                    labelStyle: TextStyle(color: kBrown300),
                    hintText: '0911..',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
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
                  onSaved: (value) {
                    setState(() {
                      this._application['phone'] = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20.0,
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
                    isCollapsed: true,
                    labelText: "Email",
                    labelStyle: TextStyle(color: kBrown300),
                    hintText: 'someone@example.com',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
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
                  onSaved: (value) {
                    setState(() {
                      this._application['email'] = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20.0,
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
                    isCollapsed: true,
                    labelText: "Message",
                    labelStyle: TextStyle(color: kBrown300),
                    hintText: 'I would like to apply for..',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
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
                  onSaved: (value) {
                    setState(() {
                      this._application['message'] = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
                    listener: (context, state) {
                      if (state is ApplicationOperationFailure) {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('There is an Error')));
                      }
                    },
                    builder: (context, state) {
                      return RaisedButton(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 5.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
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
                        color: kBrown400,
                        textColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.args.edit ? 'Update' : 'Submit',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
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
