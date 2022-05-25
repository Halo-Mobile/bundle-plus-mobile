import 'package:bundle_plus/viewmodel/base_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;

class ResetPasswordViewModel extends BaseViewModel {
  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print(e.toString());
      // Fluttertoast.showToast(msg: e.toString());
      return false;
    }
  }
}
