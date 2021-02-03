import 'dart:io';

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

  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _phone = '';

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  String _fileName;
  List<PlatformFile> _paths;
  String _directoryPath;
  String _extension;
  bool _loadingPth = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  void _openFileExplorer() async {
    setState(() => _loadingPth = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll('', '')?.split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print('Unsupported operation' + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPth = false;
      _fileName = _paths != null ? _paths.map((e) => e.name).toString() : '...';
    });
  }

  // void _clearCachedFiles() {
  //   FilePicker.platform.clearTemporaryFiles().then((result) {
  //     _scaffoldKey.currentState.showSnackBar(
  //       SnackBar(
  //         backgroundColor: result ? Colors.green : Colors.red,
  //         content: Text((result
  //             ? 'Temporary files removed with success.'
  //             : 'Failed to clean temporary files')),
  //       ),
  //     );
  //   });
  // }

  void _selectFolder() {
    FilePicker.platform.getDirectoryPath().then((value) {
      setState(() => _directoryPath = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
    final pickedFile = _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile as PickedFile;
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
