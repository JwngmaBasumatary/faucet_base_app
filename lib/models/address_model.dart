class AddressModel {
  int? points;
  int? clicksLeft;
  int? basicScratchLeft;
  int? silverScratchLeft;
  int? goldScratchLeft;
  int? diamondScratchLeft;
  int? ticTacToeLeft;
  int? mindGameLeft;

  AddressModel({
    required this.points,
    required this.clicksLeft,
    required this.basicScratchLeft,
    required this.silverScratchLeft,
    required this.goldScratchLeft,
    required this.ticTacToeLeft,
    required this.mindGameLeft,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    points = json['points'];
    clicksLeft = json['clicksLeft'];
    basicScratchLeft = json['basicScratchLeft'];
    silverScratchLeft = json['silverScratchLeft'];
    goldScratchLeft = json['goldScratchLeft'];
    diamondScratchLeft = json['diamondScratchLeft'];
    ticTacToeLeft = json['ticTacToeLeft'];
    mindGameLeft = json['mindGameLeft'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['points'] = points;
    data['clicksLeft'] = clicksLeft;
    data['basicScratchLeft'] = basicScratchLeft;
    data['silverScratchLeft'] = silverScratchLeft;
    data['goldScratchLeft'] = goldScratchLeft;
    data['diamondScratchLeft'] = diamondScratchLeft;
    data['ticTacToeLeft'] = ticTacToeLeft;
    data['mindGameLeft'] = mindGameLeft;

    return data;
  }
}
