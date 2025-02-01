import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/widgets.dart';
import 'package:todomaker/entity/remote_config_parameter.dart';
import 'package:todomaker/utils/analytics/error.dart';

final remoteConfig = FirebaseRemoteConfig.instance;

Future<void> setupRemoteConfig() async {
  try {
    await (
      remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      )),
      remoteConfig.setDefaults({
        RemoteConfigKeys.minimumAppVersion: RemoteConfigParameterDefaultValues.minimumAppVersion,
      }),
      remoteConfig.fetchAndActivate()
    ).wait;

    debugPrintRemoteConfig();

    remoteConfig.onConfigUpdated.listen((event) {
      remoteConfig.activate();
    });
  } catch (error, st) {
    // ignore error
    // ParallelWaitErrorとentrypointでRemoteConfigを導入してからエラーが出るようになった。RemoteConfigの設定は失敗しても最悪どうにかなるだろう。ということでエラーは無視する
    debugPrint(error.toString());
    errorLogger.recordError(error, st);
  }
}

void debugPrintRemoteConfig() {
  for (final entry in remoteConfig.getAll().entries) {
    debugPrint('RemoteConfig: ${entry.key} ${entry.value.asString()}');
  }
}
