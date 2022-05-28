import 'package:bundle_plus/mvvm_template/template_viewmodel.dart';
import 'package:bundle_plus/screens/base_view.dart';
import 'package:bundle_plus/screens/home.dart';
import 'package:bundle_plus/viewmodel/registration_verify_viewmodel.dart';
import 'package:flutter/material.dart';

class RegistrationVerifyView extends StatelessWidget {
  const RegistrationVerifyView({Key? key}) : super(key: key);

  // final RegistrationVerifyViewModel _model;
  // final bool isEmailVerified = false;

  @override
  Widget build(BuildContext context) {
    return BaseView<RegistrationVerifyViewModel>(
        onModelReady: (model) {
          model.onModelReady();
        },
        builder: (context, model, child) => model.isEmailVerified
            ? const HomeScreen()
            : Scaffold(
                appBar: AppBar(
                  title: Text('Verify Email Page'),
                ),
                body: Container(
                  child: Text(
                    'Please check your email to complete the verification process\n This screen will automatically refresh once you have \n completed the verification process',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ));
  }

  // @override
  // Widget build(BuildContext context) {
  //   return BaseView<RegistrationVerifyViewModel>(
  //  onModelReady: (model) {
  //     model.onModelReady();
  //   }, builder: (context, model, child) {
  //     model.onModelReady();
  //     return Scaffold(
  //       appBar: AppBar(
  //         title: Text('Verify Email'),
  //       ),
  //       body: Center(
  //         child: Container(
  //           child: Text(
  //               'Email fverification sent. Please check your email inbox \nto complete your registration process'),
  //         ),
  //       ),
  //     );
  //   });
  // }

}
