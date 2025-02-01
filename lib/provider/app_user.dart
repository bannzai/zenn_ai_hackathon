import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todomaker/entity/app_user.dart';
import 'package:todomaker/features/root/resolver/database.dart';

part 'app_user.g.dart';

@Riverpod(dependencies: [appUser])
String appUserID(AppUserIDRef ref) {
  return ref.watch(appUserProvider).asData?.value.id ?? FirebaseAuth.instance.currentUser!.uid;
}

@Riverpod(dependencies: [userDatabase])
Stream<AppUser> appUser(AppUserRef ref) {
  final database = ref.watch(userDatabaseProvider);
  return database.userReference().snapshots().map((event) => event.data()!);
}
