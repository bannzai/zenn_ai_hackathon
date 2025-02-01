// ignore: implementation_imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:replai/components/loading/indicator.dart';
import 'package:replai/components/retry/page.dart';
import 'package:replai/entity/app_user.dart';
import 'package:replai/features/resolver/database.dart';
import 'package:replai/provider/app_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_user_create.g.dart';

class AppUserCreate {
  final UserDatabase userDatabase;

  AppUserCreate({required this.userDatabase});

  Future<void> call() async {
    final document = await userDatabase.userReference().get();
    if (document.exists) {
      return;
    }
    await userDatabase.userReference().set(
          const AppUser(),
          SetOptions(merge: true),
        );
  }
}

@Riverpod(dependencies: [userDatabase])
AppUserCreate appUserCreate(AppUserCreateRef ref) {
  return AppUserCreate(userDatabase: ref.watch(userDatabaseProvider));
}

class AppUserCreateResolver extends HookConsumerWidget {
  final Widget Function(BuildContext) builder;

  const AppUserCreateResolver({super.key, required this.builder});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUser = ref.watch(appUserProvider);
    final appUserCreate = ref.watch(appUserCreateProvider);

    useEffect(() {
      appUserCreate();
      return null;
    }, []);

    return Retry(
      retry: () => ref.invalidate(appUserProvider),
      child: () {
        return appUser.when(
          data: (appUser) => builder(context),
          error: (e, st) => RetryPage(
            exception: e,
          ),
          loading: () => const IndicatorPage(),
        );
      }(),
    );
  }
}
