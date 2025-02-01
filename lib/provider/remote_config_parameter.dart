import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:todomaker/entity/remote_config_parameter.dart';
import 'package:todomaker/utils/config/remote_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_config_parameter.g.dart';

@Riverpod()
RemoteConfigParameter remoteConfigParameter(RemoteConfigParameterRef ref) {
  // fetchAndActiveをentrypointで完了しているので値が取れる想定
  return RemoteConfigParameter(
    minimumAppVersion: remoteConfig.getStringOrDefault(
      RemoteConfigKeys.minimumAppVersion,
      RemoteConfigParameterDefaultValues.minimumAppVersion,
    ),
  );
}

extension RemoteConfigExt on FirebaseRemoteConfig {
  bool getBoolOrDefault(String key, bool defaultValue) {
    try {
      return getAll().containsKey(key) ? getBool(key) : defaultValue;
    } catch (error) {
      return defaultValue;
    }
  }

  int getIntOrDefault(String key, int defaultValue) {
    try {
      return getAll().containsKey(key) ? getInt(key) : defaultValue;
    } catch (error) {
      return defaultValue;
    }
  }

  String getStringOrDefault(String key, String defaultValue) {
    try {
      return getAll().containsKey(key) ? getString(key) : defaultValue;
    } catch (error) {
      return defaultValue;
    }
  }
}
