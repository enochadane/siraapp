import 'dart:io';

import 'package:app/constants/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePageForm extends StatefulWidget {
  @override
  _ProfilePageFormState createState() => _ProfilePageFormState();
}

class _ProfilePageFormState extends State<ProfilePageForm> {
  PickedFile _imageFile;
  final ImagePicker _picker = new ImagePicker();

  final _formKey = GlobalKey<FormState>();

  // ignore: unused_field
  String _firstName = '';
  // ignore: unused_field
  String _email = '';

  final _firstNameController = TextEditingController();

  void _openFileExplorer() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path);
    } else {}

    if (result != null) {
      PlatformFile file = result.files.first;
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBrown400,
        title: Text('Edit Profile'),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _buildProfilePhotoField(),
                SizedBox(
                  height: 20.0,
                ),
                _buildFirstNameField(),
                SizedBox(
                  height: 20.0,
                ),
                _buildLastNameField(),
                SizedBox(
                  height: 20.0,
                ),
                _buildEmailField(),
                SizedBox(
                  height: 20.0,
                ),
                _buildPhoneFiled(),
                SizedBox(
                  height: 20.0,
                ),
                _buildFileUploadField(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFullNameField() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _buildFirstNameField(),
        _buildLastNameField(),
      ],
    );
  }

  Widget _buildProfilePhotoField() {
    return Stack(
      children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null
              ? AssetImage('assets/images/profile.png')
              : FileImage(File(_imageFile.path)),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (builder) => _buildBottomSheet(),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 28.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Choose Profile photo',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text('Camera'),
              ),
              FlatButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: Icon(Icons.image),
                label: Text('Gallery'),
              )
            ],
          ),
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget _buildFirstNameField() {
    return TextFormField(
      controller: _firstNameController,
      validator: (value) => value.isEmpty ? 'First Name is required' : null,
      onSaved: (value) => _firstName = value,
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
        prefixIcon: Icon(Icons.person),
      ),
    );
  }

  Widget _buildLastNameField() {
    return TextFormField(
      controller: _firstNameController,
      validator: (value) => value.isEmpty ? 'Last Name cannot be empty' : null,
      onSaved: (value) => _firstName = value,
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
        prefixIcon: Icon(Icons.person),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      onChanged: (value) => _email = value,
      validator: (value) => !isEmail(value)
          ? "Sorry, we do not recognize this email address"
          : null,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        // alignLabelWithHint: true,
        prefixIcon: Icon(Icons.alternate_email),
        // hintText: 'Enter your email',
        border: InputBorder.none,
        filled: true,
        fillColor: Color(0xfff3f3f4),
      ),
    );
  }

  Widget _buildPhoneFiled() {
    return TextFormField(
      controller: _firstNameController,
      // validator: (value) => value.isEmpty ? 'Last Name cannot be empty' : null,
      onSaved: (value) => _firstName = value,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Tele Phone',
        focusColor: Color(0xff4064f3),
        labelStyle: TextStyle(
          color: Color(0xff4064f3),
        ),
        border: InputBorder.none,
        filled: true,
        fillColor: Color(0xfff3f3f4),
        prefixIcon: Icon(Icons.phone_android),
      ),
    );
  }

  Widget _buildFileUploadField() {
    return RaisedButton(
      color: kBrown500,
      textColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      onPressed: () => _openFileExplorer(),
      child: Text('Upload CV'),
    );
  }

  bool isEmail(String value) {
    String regex =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(regex);

    return value.isNotEmpty && regExp.hasMatch(value);
  }
}
