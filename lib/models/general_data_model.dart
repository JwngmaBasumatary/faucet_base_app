import 'package:cloud_firestore/cloud_firestore.dart';

class GeneralDataModel {
  num? users;
  num? appVersion;
  Timestamp? lastNotified;
  bool? appStatus;
  bool? blocked;
  String? newApp;
  bool? withdrawStatus;

  GeneralDataModel(
      {required this.users,
        required this.appVersion,
        required this.lastNotified,
        required this.appStatus,
        required this.blocked,
        required this.newApp,
        required this.withdrawStatus});

  Map toMap(GeneralDataModel generalDataModel) {
    var data = <String, dynamic>{};
    data['users'] = generalDataModel.users;
    data['appVersion'] = generalDataModel.appVersion;
    data['lastNotified'] = generalDataModel.lastNotified;
    data['appStatus'] = generalDataModel.appStatus;
    data['blocked'] = generalDataModel.blocked;
    data['newApp'] = generalDataModel.newApp;
    data['withdrawStatus'] = generalDataModel.withdrawStatus;

    return data;
  }

  GeneralDataModel.fromMap(Map<String, dynamic> mapData) {
    users = mapData['users'];
    appVersion = mapData['appVersion'];
    lastNotified = mapData['lastNotified'];
    appStatus = mapData['appStatus'];
    blocked = mapData['blocked'];
    newApp = mapData['newApp'];
    withdrawStatus = mapData['withdrawStatus'];
  }
}
