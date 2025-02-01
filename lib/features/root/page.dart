import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todomaker/features/home/page.dart';
import 'package:todomaker/features/root/resolver/app_resolvers.dart';
import 'package:todomaker/features/root/resolver/app_user_create.dart';
import 'package:todomaker/features/root/resolver/force_update.dart';
import 'package:todomaker/features/root/resolver/purchase_setup.dart';

class RootPage extends HookConsumerWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppResolvers(builder: (context, user) {
      return AppUserCreateResolver(builder: (context) {
        return ForceUpdateResolver(builder: (context) {
          return PurchaseSetupResolver(
            userID: user.uid,
            builder: (context) {
              return const HomePage();
            },
          );
        });
      });
    });
  }
}
