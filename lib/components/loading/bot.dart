import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class BotLoading extends StatelessWidget {
  final List<String> messages;
  final VoidCallback onStop;

  const BotLoading({super.key, required this.messages, required this.onStop});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.78),
        ),
        child: Center(
          child: Column(
            children: [
              BotChat(messages: messages),
              const SizedBox(height: 12),
              const Text('※ 時間がかかり過ぎているようであれば、一度停止して再度実行してください。', style: TextStyle(fontSize: 12)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TextButton.icon(
                  onPressed: () {
                    onStop();
                  },
                  icon: const Icon(Icons.stop),
                  label: const Text('停止'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BotChat extends StatelessWidget {
  final List<String> messages;

  const BotChat({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: Colors.black,
          shadows: [
            Shadow(color: Colors.blueGrey, blurRadius: 2),
          ],
        ),
        child: Row(
          children: [
            const Spacer(),
            const Text('🤖'),
            const SizedBox(width: 2),
            Container(
              constraints: const BoxConstraints(maxWidth: 300),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  for (var message in messages) TyperAnimatedText(message, speed: const Duration(milliseconds: 60)),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
