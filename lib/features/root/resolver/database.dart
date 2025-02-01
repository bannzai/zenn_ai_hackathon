// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:replai/components/loading/indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:replai/entity/chat_partner.dart';
import 'package:replai/entity/app_user.dart';
import 'package:replai/features/resolver/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../entity/chat_message.dart';

part 'database.g.dart';

abstract class _CollectionPath {
  static const String users = "/users";
  static String chatPartners({required String userID}) => "/users/$userID/chatPartners";
  static String chatMessages({required String userID, required String chatPartnerID}) => "/users/$userID/chatPartners/$chatPartnerID/chatMessages";
}

@Riverpod(keepAlive: true, dependencies: [])
UserDatabase userDatabase(UserDatabaseRef ref) {
  throw UnimplementedError("userDatabase is not implemented");
}

class UserDatabase {
  final String userID;
  UserDatabase({required this.userID});

  final FromFirestore<AppUser> _userFromFirestore = (snapshot, options) => AppUser.fromJson(snapshot.data()!..["id"] = snapshot.id);
  final ToFirestore<AppUser> _userToFirestore = (user, options) => user.toJson();
  DocumentReference<AppUser> userReference() => FirebaseFirestore.instance.collection(_CollectionPath.users).doc(userID).withConverter(
        fromFirestore: _userFromFirestore,
        toFirestore: _userToFirestore,
      );

  final FromFirestore<ChatPartner> _chatPartnerFromFirestore = (snapshot, options) => ChatPartner.fromJson(snapshot.data()!..["id"] = snapshot.id);
  final ToFirestore<ChatPartner> _chatPartnerToFirestore = (chatPartner, options) => chatPartner.toJson();
  CollectionReference<ChatPartner> chatPartnersReference() =>
      FirebaseFirestore.instance.collection(_CollectionPath.chatPartners(userID: userID)).withConverter(
            fromFirestore: _chatPartnerFromFirestore,
            toFirestore: _chatPartnerToFirestore,
          );
  DocumentReference<ChatPartner> chatPartnerReference({
    required String chatPartnerID,
  }) =>
      FirebaseFirestore.instance.collection(_CollectionPath.chatPartners(userID: userID)).doc(chatPartnerID).withConverter(
            fromFirestore: _chatPartnerFromFirestore,
            toFirestore: _chatPartnerToFirestore,
          );

  final FromFirestore<ChatMessage> _chatMessageFromFirestore = (snapshot, options) => ChatMessage.fromJson(snapshot.data()!..["id"] = snapshot.id);
  final ToFirestore<ChatMessage> _chatMessageToFirestore = (chatMessage, options) => chatMessage.toJson();
  CollectionReference<ChatMessage> chatMessagesReference({required String chatPartnerID}) => FirebaseFirestore.instance
      .collection(
        _CollectionPath.chatMessages(
          userID: userID,
          chatPartnerID: chatPartnerID,
        ),
      )
      .withConverter(
        fromFirestore: _chatMessageFromFirestore,
        toFirestore: _chatMessageToFirestore,
      );
  DocumentReference<ChatMessage> chatMessageReference({
    required String chatPartnerID,
    required String chatMessageID,
  }) =>
      FirebaseFirestore.instance
          .collection(_CollectionPath.chatMessages(userID: userID, chatPartnerID: chatPartnerID))
          .doc(chatMessageID)
          .withConverter(
            fromFirestore: _chatMessageFromFirestore,
            toFirestore: _chatMessageToFirestore,
          );
}

class UserDatabaseResolver extends HookConsumerWidget {
  final Widget Function(BuildContext) builder;

  const UserDatabaseResolver({super.key, required this.builder});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(firebaseUserChangesProvider).asData?.value;

    useEffect(() {
      if (user == null) {
        ref.invalidate(userDatabaseProvider);
      }
      return null;
    }, [user]);

    if (user != null) {
      return ProviderScope(
        overrides: [userDatabaseProvider.overrideWith((ref) => UserDatabase(userID: user.uid))],
        child: Consumer(
          builder: ((context, ref, child) => builder(context)),
        ),
      );
    } else {
      return const IndicatorPage();
    }
  }
}
