import 'dart:async';

import 'package:bundle_plus/viewmodel/base_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationVerifyViewModel extends BaseViewModel {
  bool isEmailVerified = false;
  Timer? timer;

  void onModelReady() {
    print('init verify viewmodel');
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    print(FirebaseAuth.instance.currentUser!);
    print(isEmailVerified);
    notifyListeners();

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(), // check email verified msg in 3 sec
      );
    }
  }

  void onModelDestroy() {
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async {
    print('checkEmail');
    // call after email verification
    await FirebaseAuth.instance.currentUser!.reload();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    notifyListeners();

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    print('sendverification email');
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
  }

  bool isVerified() {
    print(FirebaseAuth.instance.currentUser!);
    print(isEmailVerified);
    return isEmailVerified;
  }
}
