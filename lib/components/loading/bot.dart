import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BotLoading extends StatelessWidget {
  final List<String> messages;

  const BotLoading({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
        ),
        child: Center(
          child: BotChat(messages: messages),
        ),
      ),
    );
  }
}

class BotChat extends HookWidget {
  final List<String> messages;

  const BotChat({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    final count = useState(0);
    final message = messages[count.value % messages.length];

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
            onNext: (_, __) {
              count.value += 1;
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
