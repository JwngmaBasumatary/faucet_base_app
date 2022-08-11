import 'package:cloud_firestore/cloud_firestore.dart';

class AppData {
  String? name;
  String? profilePhoto;
  String? email;
  Timestamp? createdOn;
  Timestamp? lastLogin;

  AppData(
      {required this.createdOn,
      required this.lastLogin,
      required this.name,
      required this.email,
      required this.profilePhoto});

  AppData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    createdOn = json['createdOn'];
    lastLogin = json['lastLogin'];
    profilePhoto = json['profilePhoto'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['createdOn'] = createdOn;
    data['lastLogin'] = lastLogin;
    data['name'] = name;
    data['profilePhoto'] = profilePhoto;
    data['email'] = email;
    return data;
  }
}
