import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class BotChat extends StatelessWidget {
  final String message;

  const BotChat({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(fontSize: 24, color: Colors.black),
      child: Row(
        children: [
          const Spacer(),
          const Text('🤖'),
          const SizedBox(width: 2),
          AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              TyperAnimatedText(message),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
