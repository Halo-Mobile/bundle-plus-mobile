import 'package:bundle_plus/model/user_model.dart';
import 'package:bundle_plus/screens/login.dart';
import 'package:bundle_plus/viewmodel/base_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminHomeViewModel extends BaseViewModel {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  // MVVM, init = onModelReady()
  void onModelReady() {
    // print('adminhome init');
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      notifyListeners(); // setState() for MVVM
      // print(loggedInUser.email);
    });
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  // void logout(BuildContext context) {}
}
