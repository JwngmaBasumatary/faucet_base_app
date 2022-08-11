import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String? uid;
  String? name;
  String? country;
  int? points;
  int? newNotification;
  String? email;
  // String? coinAddress;
  String? profilePhoto;
  int? clicks;
  // int? clicksLeft;
  String? idToken;
  int? claimed;
  int? earnedByReferral;
  Timestamp? createdOn;
  Timestamp? lastLogin;
  Timestamp? basicScratchTimer;
  Timestamp? goldScratchTimer;
  Timestamp? diamondScratchTimer;
  Timestamp? silverScratchTimer;
  Timestamp? nextSpinTime;
  Timestamp? nextNumberGameTime;
  int? basicScratchLeft;
  int? silverScratchLeft;
  int? goldScratchLeft;
  int? diamondScratchLeft;
  int? spinsLeft;
  int? numberGameLeft;
  String? referralId;
  String? referredBy;
  int? today;
  Timestamp? nextPayment;
  Timestamp? lastWithdrawal;
  int? successClaims;
  int? version;
  bool? status;
  bool? accountReset;

  Users({
    this.uid,
    this.name,
    this.country,
    this.idToken,
    this.email,
    this.points,
    this.newNotification,
    this.basicScratchTimer,
    this.goldScratchTimer,
    this.diamondScratchTimer,
    this.silverScratchTimer,
    this.nextSpinTime,
    this.nextNumberGameTime,
    this.basicScratchLeft,
    this.silverScratchLeft,
    this.goldScratchLeft,
    this.diamondScratchLeft,
    this.spinsLeft,
    this.numberGameLeft,
    this.clicks,
    this.profilePhoto,
    this.claimed,
    this.earnedByReferral,
    this.createdOn,
    this.lastLogin,
    this.referralId,
    this.referredBy,
    this.today,
    this.nextPayment,
    this.lastWithdrawal,
    this.successClaims,
    this.version,
    this.status,
    this.accountReset,
  });

  Map toMap(Users users) {
    var data = <dynamic, dynamic>{};
    data['uid'] = users.uid;
    data['name'] = users.name;
    data['country'] = users.country;
    data['email'] = users.email;
    data['idToken'] = users.idToken;
    data['basicScratchTimer'] = users.basicScratchTimer;
    data['goldScratchTimer'] = users.goldScratchTimer;
    data['silverScratchTimer'] = users.silverScratchTimer;
    data['nextSpinTime'] = users.nextSpinTime;
    data['nextNumberGameTime'] = users.nextNumberGameTime;
    data['basicScratchLeft'] = users.basicScratchLeft;
    data['silverScratchLeft'] = users.silverScratchLeft;
    data['goldScratchLeft'] = users.goldScratchLeft;
    data['spinsLeft'] = users.spinsLeft;
    data['numberGameLeft'] = users.numberGameLeft;
    data['points'] = users.points;
    data['clicks'] = users.clicks;
    data['profilePhoto'] = users.profilePhoto;
    data['claimed'] = users.claimed;
    data['earnedByReferral'] = users.earnedByReferral;
    data['createdOn'] = users.createdOn;
    data['lastLogin'] = users.lastLogin;
    data['referralId'] = users.referralId;
    data['referredBy'] = users.referredBy;
    data['today'] = users.today;
    data['nextPayment'] = users.nextPayment;
    data['lastWithdrawal'] = users.lastWithdrawal;
    data['successClaims'] = users.successClaims;
    data['version'] = users.version;
    data['status'] = users.status;
    data['accountReset'] = users.accountReset;

    return data;
  }

  Users.fromMap(Map<dynamic, dynamic> mapData) {
    uid = mapData['uid'];
    name = mapData['name'];
    country = mapData['country'];
    email = mapData['email'];
    idToken = mapData['idToken'];
    basicScratchTimer = mapData['basicScratchTimer'];
    silverScratchTimer = mapData['silverScratchTimer'];
    goldScratchTimer = mapData['goldScratchTimer'];
    nextNumberGameTime = mapData['nextNumberGameTime'];
    nextSpinTime = mapData['nextSpinTime'];
    basicScratchLeft = mapData['basicScratchLeft'];
    silverScratchLeft = mapData['silverScratchLeft'];
    goldScratchLeft = mapData['goldScratchLeft'];
    spinsLeft = mapData['spinsLeft'];
    numberGameLeft = mapData['numberGameLeft'];
    points = mapData['points'];
    clicks = mapData['clicks'];
    profilePhoto = mapData['profilePhoto'];
    claimed = mapData['claimed'];
    earnedByReferral = mapData['earnedByReferral'];
    createdOn = mapData['createdOn'];
    lastLogin = mapData['lastLogin'];
    referralId = mapData['referralId'];
    referredBy = mapData['referredBy'];
    today = mapData['today'];
    nextPayment = mapData['nextPayment'];
    lastWithdrawal = mapData['lastWithdrawal'];
    successClaims = mapData['successClaims'];
    version = mapData['version'];
    status = mapData['status'];
    accountReset = mapData['accountReset'];
  }
}
