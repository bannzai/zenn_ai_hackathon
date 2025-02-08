import 'package:flutter/material.dart';

class OnboardingResolver extends StatelessWidget {
  final WidgetBuilder builder;

  OnboardingResolver({required this.builder});

  Widget build(BuildContext context) {
    return builder(context);
  }
}
