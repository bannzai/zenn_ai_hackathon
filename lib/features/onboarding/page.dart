import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class OnboardingPage extends HookWidget {
  final ValueNotifier<bool> isOnboardingResolved;
  const OnboardingPage({super.key, required this.isOnboardingResolved});

  @override
  Widget build(BuildContext context) {
    final index = useState(0);
    final animationController = useAnimationController(duration: const Duration(milliseconds: 400));
    index.addListener(() {
      if (index.value == 1) {
        animationController.forward();
      }
    });

    return Scaffold(
      body: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: Colors.black,
          shadows: [
            Shadow(color: Colors.blueGrey, blurRadius: 2),
          ],
        ),
        child: SafeArea(
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
                    onFinished: () => index.value++,
                  ),
                  const Spacer(),
                ],
              ),
              if (index.value <= 1) ...[
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
        ),
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

class OnboardingBot extends StatelessWidget {
  final List<String> messages;

  const OnboardingBot({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
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
        ],
      ),
    );
  }
}
