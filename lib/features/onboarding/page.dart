import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todomaker/features/onboarding/components/body_1.dart';
import 'package:todomaker/features/onboarding/components/event.dart';

class OnboardingPage extends HookWidget {
  final ValueNotifier<bool> isOnboardingResolved;
  const OnboardingPage({super.key, required this.isOnboardingResolved});

  @override
  Widget build(BuildContext context) {
    final index = useState(OnboardingEvent.initial);
    final animationController = useAnimationController(duration: const Duration(milliseconds: 400));
    index.addListener(() {
      if (index.value == OnboardingEvent.showTapLabel) {
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
          child: OnboardingBody1(index: index, animationController: animationController),
        ),
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
