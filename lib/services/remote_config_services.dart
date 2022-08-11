import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../utils/constants.dart';

import '../models/latest_app.dart';

class RemoteConfigServices {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> checkLatestVersion() async {
    final RemoteConfig remoteConfig = RemoteConfig.instance;
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: Duration.zero,
      ));
      await remoteConfig.fetchAndActivate();

      var requiredString =
          remoteConfig.getString(Constants.appVersionFromRemote);
      return requiredString;
    } on PlatformException catch (exception) {
      debugPrint(exception.toString());
      return '';
    } catch (exception) {
      debugPrint(
          'Unable to fetch remote config. Cached or default values will be used for force_update_current_version');
      return '';
    }
  }

  Future<String> getValueFromRemoteConfig(String value) async {
    final RemoteConfig remoteConfig = RemoteConfig.instance;
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: Duration.zero,
      ));
      await remoteConfig.fetchAndActivate();

      var requiredString = remoteConfig.getString(value);
      return requiredString;
    } on PlatformException catch (exception) {
      debugPrint(exception.toString());
      return '';
    } catch (exception) {
      debugPrint(
          'Unable to fetch remote config. Cached or default values will be used for $value');
      return '';
    }
  }

  static Future getLatestApp() async {
    final RemoteConfig remoteConfig = RemoteConfig.instance;
    try {
      remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: Duration.zero,
      ));
      remoteConfig.fetchAndActivate();

      var requiredString = remoteConfig.getString(Constants.latestAppFromRemote);

      var jsonResponse = json.decode(requiredString);
      return LatestApp.fromMap(jsonResponse);
    } on PlatformException catch (exception) {
      debugPrint(exception.toString());
    } catch (exception) {
      debugPrint(
          'Unable to fetch remote config. Cached or default values will be used for Latest Apps');
    }
  }
}
