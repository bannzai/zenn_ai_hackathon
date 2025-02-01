import 'dart:io';

String get storeName {
  return Platform.isIOS ? 'App Store' : 'Google Play';
}

String get accountName {
  return Platform.isIOS ? 'Apple ID' : 'Google アカウント';
}

String get forceUpdateStoreURL {
  return Platform.isIOS ? 'https://apps.apple.com/app/apple-store/id6741352387?pt=97327896&ct=force_update&mt=8' : '';
}
