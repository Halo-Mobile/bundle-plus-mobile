// Copy this template to make MVVM view

import 'package:bundle_plus/mvvm_template/template_viewmodel.dart';
import 'package:flutter/material.dart';

import '../screens/base_view.dart';

class TemplateView extends StatelessWidget {
  const TemplateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<TemplateViewModel>(builder: (context, model, child) {
      return Scaffold();
    });
  }
}
