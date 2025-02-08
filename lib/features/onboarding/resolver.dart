import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todomaker/features/onboarding/page.dart';
import 'package:todomaker/provider/shared_preferences.dart';

class OnboardingResolver extends HookConsumerWidget {
  final WidgetBuilder builder;

  const OnboardingResolver({super.key, required this.builder});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOnboardingResolved = ref.watch(sharedPreferencesProvider).getBool(onboardingResolvedKey);
    final isOnboardingResolvedState = useState(isOnboardingResolved ?? false);
    isOnboardingResolvedState.addListener(() {
      if (isOnboardingResolvedState.value) {
        return;
      }
    });

    if (isOnboardingResolvedState.value) {
      return builder(context);
    }

    return OnboardingPage(isOnboardingResolved: isOnboardingResolvedState);
  }
}
