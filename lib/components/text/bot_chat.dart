import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class BotChat extends StatelessWidget {
  final String message;

  const BotChat({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('🤖'),
        const SizedBox(width: 2),
        AnimatedTextKit(
          totalRepeatCount: 1,
          animatedTexts: [
            TypewriterAnimatedText(message),
          ],
        ),
      ],
    );
  }
}
