import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todomaker/entity/remote_config_parameter.dart';
import 'package:todomaker/provider/remote_config_parameter.dart';
import 'package:todomaker/utils/analytics/analytics.dart';
import 'package:todomaker/utils/config/version.dart';

final checkForceUpdateProvider = Provider.autoDispose(
  (ref) => CheckForceUpdate(
    remoteConfigParameter: ref.watch(
      remoteConfigParameterProvider,
    ),
  ),
);

class CheckForceUpdate {
  final RemoteConfigParameter remoteConfigParameter;

  CheckForceUpdate({required this.remoteConfigParameter});

// Return false: should not force update
// Return true: should force update
  Future<bool> call() async {
    final config = remoteConfigParameter;
    final packageVersion = await Version.fromPackage();

    final forceUpdate = packageVersion.isLessThan(Version.parse(config.minimumAppVersion));
    if (forceUpdate) {
      analytics.logEvent(
        name: 'screen_type_force_update',
        parameters: {
          'package_version': packageVersion.toString(),
          'minimum_app_version': config.minimumAppVersion,
        },
      );
    }
    return forceUpdate;
  }
}
