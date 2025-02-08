import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:todomaker/features/onboarding/components/event.dart';

class OnboardingBody1 extends StatelessWidget {
  const OnboardingBody1({
    super.key,
    required this.index,
    required this.animationController,
    required this.onNext,
  });

  final ValueNotifier<OnboardingEvent> index;
  final AnimationController animationController;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onNext,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              OnboardingBot1(
                messages: const [
                  'こんにちは！',
                  'TODOMakerへようこそ',
                ],
                onFinished: () => index.value = OnboardingEvent.showTapLabel,
              ),
              const Spacer(),
            ],
          ),
          if (index.value.index <= OnboardingEvent.showTapLabel.index) ...[
            Positioned(
              bottom: 20,
              child: SizedBox(
                height: 100,
                child: FadeTransition(
                  opacity: Tween<double>(begin: 0, end: 1).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: Curves.easeInOut,
                    ),
                  ),
                  child: const Text(
                    'タップして次へ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      shadows: [Shadow(color: Colors.blueGrey, blurRadius: 2)],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class OnboardingBot1 extends StatelessWidget {
  final List<String> messages;
  final VoidCallback onFinished;

  const OnboardingBot1({super.key, required this.messages, required this.onFinished});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🤖'),
          const SizedBox(width: 2),
          Container(
            constraints: const BoxConstraints(maxWidth: 300),
            child: AnimatedTextKit(
                isRepeatingAnimation: false,
                animatedTexts: [
                  for (var message in messages) TyperAnimatedText(message, speed: const Duration(milliseconds: 90)),
                ],
                onNext: (index, isLast) {
                  debugPrint('index: $index, isLast: $isLast');
                  if (isLast) {
                    onFinished();
                  }
                }),
          ),
        ],
      ),
    );
  }
}
