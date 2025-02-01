import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:todomaker/features/root/resolver/database.dart';
import 'package:todomaker/utils/local_notification/client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'request_permission.g.dart';

Future<void> requestNotificationPermissions(RegisterRemotePushNotificationToken registerRemotePushNotificationToken) async {
  if (Platform.isIOS) {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
    await FirebaseMessaging.instance.requestPermission(alert: true, badge: true, sound: true, announcement: true);
    await localNotificationService.requestPermission();
    final token = await FirebaseMessaging.instance.getToken();
    registerRemotePushNotificationToken(token);
  }
}

class RegisterRemotePushNotificationToken {
  final UserDatabase database;

  RegisterRemotePushNotificationToken(this.database);

  Future<void> call(String? token) {
    return database.userPrivateRawReference().set(
      {'fcmToken': token},
      SetOptions(merge: true),
    );
  }
}

@Riverpod(dependencies: [userDatabase])
RegisterRemotePushNotificationToken registerRemotePushNotificationToken(RegisterRemotePushNotificationTokenRef ref) =>
    RegisterRemotePushNotificationToken(ref.watch(userDatabaseProvider));
