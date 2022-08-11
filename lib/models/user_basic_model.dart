class UserBasicModel {
  var points;
  var clicks;
  var referredBy;
  var email;
  var coinbase;
  var country;
  var successClaims;

  UserBasicModel({
    required this.points,
    required this.email,
    required this.coinbase,
    required this.clicks,
    required this.referredBy,
    required this.country,
    required this.successClaims,
  });

  Map toMap(UserBasicModel users) {
    var data = <String, dynamic>{};
    data['points'] = users.points;
    data['email'] = users.email;
    data['coinbase'] = users.coinbase;
    data['clicks'] = users.clicks;
    data['referredBy'] = users.referredBy;
    data['country'] = users.country;
    data['successClaims'] = users.successClaims;

    return data;
  }

  UserBasicModel.fromMap(Map<String, dynamic> mapData) {
    points = mapData['points'];
    email = mapData['email'];
    coinbase = mapData['coinbase'];
    clicks = mapData['clicks'];
    referredBy = mapData['referredBy'];
    country = mapData['country'];
    successClaims = mapData['successClaims'];
  }
}
