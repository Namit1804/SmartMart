import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_mart/controllers/auth_controller.dart';
import 'package:smart_mart/views/screens/auth/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController _authController = AuthController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late String email;

  late String fullName;

  late String password;

  Uint8List? _image;

  selectGalleryImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  captureImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.camera);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Register Account',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Stack(
                      children: [
                        _image == null
                            ? CircleAvatar(
                                radius: 65,
                                child: Icon(
                                  Icons.person,
                                  size: 70,
                                ),
                              )
                            : CircleAvatar(
                                radius: 65,
                                backgroundImage: MemoryImage(_image!),
                              ),
                        Positioned(
                          right: 0,
                          top: 15,
                          child: IconButton(
                            onPressed: () {
                              selectGalleryImage();
                            },
                            icon: Icon(CupertinoIcons.photo),
                          ),
                        ),
                      ],
                    ), // Added the closing bracket for Stack
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Email Address';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        hintText: 'Enter Email Address',
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.pink,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        fullName = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Full name must not be Empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Full Name ',
                        hintText: 'Enter Full Name',
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.pink,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        password = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password can't be Empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter Password',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.pink,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          _authController.createNewUser(
                              email, fullName, password, _image);
                        } else {
                          print('not valid');
                        }
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              letterSpacing: 4,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text('Already have an Account?'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
