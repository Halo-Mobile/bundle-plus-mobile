import 'package:bundle_plus/screens/base_view.dart';
import 'package:bundle_plus/mvvm_template/template_viewmodel.dart';
import 'package:bundle_plus/viewmodel/admin_verify_user_viewmodel.dart';
import 'package:flutter/material.dart';

class AdminVerifyUserView extends StatelessWidget {
  const AdminVerifyUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AdminVerifyUserViewModel>(builder: (context, model, child) {
      return const Scaffold();
    });
  }
}
