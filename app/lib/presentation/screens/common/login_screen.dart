import 'package:app/blocs/authentication/authentication.dart';
import 'package:app/blocs/authentication/login/login_bloc.dart';
import 'package:app/blocs/authentication/login/login_event.dart';
import 'package:app/blocs/authentication/login/login_state.dart';
import 'package:app/constants/colors.dart';
import 'package:app/presentation/screens/common/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'register_screen.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/login";

  final VoidCallback onSignedIn;
  const LoginPage({Key key, this.onSignedIn}) : super(key: key);

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool _showPassword = false;
  String _email = "";
  String _password = "";
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;

    void _showError(String error, context) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(error),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
          if (state is LoginFailure) {
            _showError("Invalid Username or Password", context);
          }
          if (state is LoginSuccess) {
            BlocProvider.of<AuthenticationBloc>(context).add(AppLoaded());
            Navigator.pushNamedAndRemoveUntil(
                context, HomePage.routeName, (route) => false);
          }
        }, builder: (context, state) {
          return Stack(children: [
            Container(
              height: height,
              decoration: BoxDecoration(),
              child: Column(children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: logo(isKeyboardShowing),
                ),
                Align(
                  alignment: isKeyboardShowing
                      ? Alignment.center
                      : Alignment.bottomCenter,
                  child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20.0),
                          height: height * 0.6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildEmailTextField(),
                              SizedBox(
                                height: 20,
                              ),
                              _buildPasswordTextField(),
                              _forgotPasswordLabel(),
                              (state is AuthenticationLoading)
                                  ? CircularProgressIndicator()
                                  : _submitButton(context),
                              _createAccountLabel(),
                            ],
                          ),
                        ),
                      )),
                ),
              ]),
            ),
          ]);
        }));
  }

  Widget logo(isKeyboardShowing) {
    return ClipPath(
      clipper: BezierClipper(),
      child: Container(
          decoration: BoxDecoration(
              color: Color(0xFF1f40b7),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [kBrown100, kBrown900])),
          width: double.infinity,
          height: isKeyboardShowing
              ? MediaQuery.of(context).size.height * 0.3
              : MediaQuery.of(context).size.height * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: isKeyboardShowing ? 90 : 100,
                width: 500,
                // child: Image.asset(
                //   'assets/images/logo.png',
                //   fit: BoxFit.cover,
                // ),
              ),
              SizedBox(
                height: isKeyboardShowing ? 10 : 30.0,
              ),
              Text(
                'Login',
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          )),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(5),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Color(0xff4064f3),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _forgotPasswordLabel() {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(5),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              'Forgot Password?',
              style: TextStyle(
                  color: Color(0xff4064f3),
                  fontSize: 16,
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      controller: _emailController,
      onChanged: (value) => _email = value.trim(),
      validator: (value) => !isEmail(value)
          ? "Sorry, we do not recognize this email address"
          : null,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email or phone number',
        labelStyle: Theme.of(context).textTheme.bodyText1,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        // alignLabelWithHint: true,
        prefixIcon: Icon(
          Icons.alternate_email,
          color: Theme.of(context).iconTheme.color,
        ),
        // hintText: 'Enter your email',
        border: InputBorder.none,
        filled: true,
        fillColor: Theme.of(context).cardTheme.color,
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      controller: _passwordController,
      validator: (value) => value.length < 4
          ? "Password must be 4 or more characters in length"
          : null,
      onChanged: (value) => _password = value.trim(),
      obscureText: !this._showPassword,
      onSaved: (value) => _password = value,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Password',
        focusColor: Color(0xff4064f3),
        labelStyle: TextStyle(
          color: Color(0xff4064f3),
        ),
        border: InputBorder.none,
        filled: true,
        fillColor: Theme.of(context).cardTheme.color,

        // fillColor: Color(0xfff3f3f4),
        prefixIcon: Icon(
          Icons.security,
          color: Theme.of(context).iconTheme.color,
        ),
        suffixIcon: IconButton(
          icon: this._showPassword
              ? FaIcon(FontAwesomeIcons.eye)
              : FaIcon(FontAwesomeIcons.eyeSlash),
          color: Theme.of(context).iconTheme.color,
          onPressed: () {
            setState(() => this._showPassword = !this._showPassword);
          },
        ),
      ),
    );
  }

  Widget _submitButton(context) {
    return InkWell(
      onTap: () {
        final form = _formKey.currentState;
        if (form.validate()) {
          form.save();
          BlocProvider.of<LoginBloc>(context).add(LoginInWithEmailButtonPressed(
              email: _email, password: _password));
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [kBrown200, kBrown900])),
        child: Text('Login',
            style: TextStyle(color: Colors.white, fontSize: 18.0)),
      ),
    );
  }

  bool isEmail(String value) {
    String regex =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(regex);

    return value.isNotEmpty && regExp.hasMatch(value);
  }
}

class BezierClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, size.height * 0.9); //vertical line
    path.cubicTo(size.width / 3, size.height, 2 * size.width / 3,
        size.height * 0.7, size.width, size.height * 0.9); //cubic curve
    path.lineTo(size.width, 0); //vertical line
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
