import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todomaker/features/home/page.dart';
import 'package:todomaker/features/root/resolver/app_user_create.dart';
import 'package:todomaker/features/root/resolver/auth.dart';
import 'package:todomaker/features/root/resolver/database.dart';
import 'package:todomaker/features/root/resolver/force_update.dart';

class RootPage extends HookConsumerWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AuthResolver(builder: (context, user) {
      return UserDatabaseResolver(builder: (context) {
        return AppUserCreateResolver(builder: (context) {
          return ForceUpdateResolver(builder: (context) {
            // return OnboardingResolver(builder: (context) {
            return const HomePage();
            // });
          });
        });
      });
    });
  }
}
