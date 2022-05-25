// Copy this template to make MVVM view

import 'package:flutter/material.dart';

class TemplateView extends StatelessWidget {
  const TemplateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<TemplateViewModel>(builder: (context, model, child) {
      return Scaffold();
    });
  }
}
