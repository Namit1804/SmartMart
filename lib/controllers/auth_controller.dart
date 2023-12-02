import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
//import 'dart:typed_data';

class AuthController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // function to Select image from gallery or camera
  _uploadProfileImageToStorage(Uint8List? image) async {
    Reference ref =
        _storage.ref().child('profilePics').child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(image!);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  pickProfileImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _file = await _imagePicker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No Image Selected');
    }
  }

  Future<String> createNewUser(
      String email, String fullName, String password, Uint8List? image) async {
    String res = 'some error occured';

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String downloadUrl = await _uploadProfileImageToStorage(image);

      await _firestore.collection('buyers').doc(userCredential.user!.uid).set({
        'fullname': fullName,
        'profileImage': downloadUrl,
        'email': email,
        'buyerId': userCredential.user!.uid,
      });

      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // ///function to Login the created user
  // Future<String> loginUser(String email, String paasword) async {
  //   String res = 'Some error Occured ';

  //   try {
  //     await _auth.signInWithEmailAndPassword(email: email, password: paasword);

  //     res = 'success';
  //   } catch (e) {
  //     res = e.toString();
  //   }

  //   return res;
}
