class UserStream {
  var points;
  var email;
  var profilePhoto;
  var newNotification;
  var nextPayment;
  var basicScratchTimer;
  var silverScratchTimer;
  var goldScratchTimer;
  var diamondScratchTimer;
  var accountReset;

  UserStream({
    required this.points,
    required this.email,
    required this.profilePhoto,
    required this.newNotification,
    required this.nextPayment,
    required this.basicScratchTimer,
    required this.silverScratchTimer,
    required this.goldScratchTimer,
    required this.diamondScratchTimer,
    required this.accountReset,
  });

  Map toMap(UserStream users) {
    var data = <String, dynamic>{};
    data['points'] = users.points;
    data['email'] = users.email;
    data['profilePhoto'] = users.profilePhoto;
    data['newNotification'] = users.newNotification;
    data['nextPayment'] = users.nextPayment;
    data['basicScratchTimer'] = users.basicScratchTimer;
    data['silverScratchTimer'] = users.silverScratchTimer;
    data['goldScratchTimer'] = users.goldScratchTimer;
    data['diamondScratchTimer'] = users.diamondScratchTimer;
    data['accountReset'] = users.accountReset;

    return data;
  }

  UserStream.fromMap(Map<String, dynamic> mapData) {
    points = mapData['points'];
    email = mapData['email'];
    profilePhoto = mapData['profilePhoto'];
    newNotification = mapData['newNotification'];
    nextPayment = mapData['nextPayment'];
    basicScratchTimer = mapData['basicScratchTimer'];
    silverScratchTimer = mapData['silverScratchTimer'];
    goldScratchTimer = mapData['goldScratchTimer'];
    diamondScratchTimer = mapData['diamondScratchTimer'];
    accountReset = mapData['accountReset'];
  }
}
