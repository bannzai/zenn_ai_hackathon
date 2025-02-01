import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:replai/features/resolver/auth.dart';
import 'package:replai/features/resolver/database.dart';

class AppResolvers extends StatelessWidget {
  final Widget Function(BuildContext context, User user) builder;

  const AppResolvers({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return AuthResolver(builder: (_, user) {
      return UserDatabaseResolver(builder: (context) {
        return builder(context, user);
      });
    });
  }
}
