import 'package:flutter/material.dart';
import 'package:medicalarm/components/loading/indicator.dart';

class Loading extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const Loading({super.key, required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading) ...[
          const Indicator(),
        ],
      ],
    );
  }
}
