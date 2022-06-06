// Use this service to use any Auth related function (Sign in, signup, sign out, get current user id, etc)

import 'package:bundle_plus/model/user_model.dart';
import 'package:bundle_plus/model/user_profile.dart';
import 'package:bundle_plus/utils/error_codes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  User get currentUser => _firebaseAuth.currentUser!;

  // Sign In with email and password
  Future<UserCredential?> signIn(String email, String password) async {
    try {
      print(_firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ));
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw signInErrorCodes[e.code] ?? 'Database Error Occured!';
    } catch (e) {
      throw '${e.toString()} Error Occured!';
    }
  }

  // Sign Up using email address
  Future<UserCredential?> signUp(String firstName, String secondName,
      String email, String password) async {
    try {
      var _user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel userModel = UserModel();

      //create new profile object to save default value
      UserProfile newProfile = UserProfile();

      // writing all the values
      userModel.email = email;
      userModel.uid = currentUser.uid;
      userModel.firstName = firstName;
      userModel.secondName = secondName;
      userModel.isVerified = false;

      //assign default value to profile object
      newProfile.upid = currentUser.uid;
      newProfile.phoneNum = "";
      newProfile.matricCard = "";
      newProfile.profilePic = 1;

      await _firebaseFirestore
          .collection("users")
          .doc(currentUser.uid)
          .set(userModel.toMap());

      await _firebaseFirestore
          .collection("users_profile")
          .doc(currentUser.uid)
          .set(newProfile.toMap());
      return _user;
    } on FirebaseAuthException catch (e) {
      debugPrint(
          signUpErrorCodes[e.code] ?? 'Firebase ${e.code} Error Occured!');
    } catch (e) {
      debugPrint('${e.toString()} Error Occured!');
    }
  }

  // Sign Out
  Future<String> signOut() async {
    await _firebaseAuth.signOut();
    return 'Signed Out Successfully';
  }
}
