import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:smart_mart/controllers/auth_controller.dart';
import 'package:smart_mart/views/screens/auth/register_screen.dart';
import 'package:smart_mart/views/screens/map_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController _authController = AuthController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _isLoading = false;

  late String email;

  late String password;

  loginUser() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      String res = await _authController.loginUser(email, password);
      setState(() {
        _isLoading = false;
      });

      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        Get.to(MapScreen());

        Get.snackbar('Success Login', 'You are now logged in',
            backgroundColor: Colors.pink[400],
            colorText: Colors.white,
            margin: EdgeInsets.all(15),
            icon: Icon(
              Icons.message,
              color: Colors.white,
              size: 40,
            ));
      } else {
        Get.snackbar('Error occured!', res.toString(),
            backgroundColor: Colors.red,
            colorText: Colors.white,
            margin: EdgeInsets.all(15),
            snackPosition: SnackPosition.BOTTOM,
            icon: Icon(
              Icons.message,
              color: Colors.white,
              size: 40,
            ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
            key: _formkey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                'Login Account',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              // Add your form fields here
              TextFormField(
                onChanged: (value) {
                  email = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email Address must not be empty.";
                  } else {
                    return null;
                  }
                },

                decoration: const InputDecoration(
                  labelText: "Email Address",
                  hintText: 'Enter Email Address',
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.pink,
                  ),
                  border: OutlineInputBorder(),
                ),
                // Add validation or other properties as needed
              ),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                onChanged: (value) {
                  password = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password is required.";
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
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  loginUser();
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: _isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Login',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 14, 12, 12),
                              fontSize: 22,
                              letterSpacing: 4,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(),
                      ));
                },
                child: Text('Create an Account'),
              ),
            ]))
        // Add other form fields or buttons as needed
        ,
      ),
    );
  }
}
