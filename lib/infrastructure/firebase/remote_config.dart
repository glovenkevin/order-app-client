import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigHelper {
  static Future<FirebaseRemoteConfig> getInstance() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 12),
    ));

    await remoteConfig
        .setDefaults(const {'base_url': 'http://10.0.2.2:8000/api/v1'});
    return remoteConfig;
  }
}
