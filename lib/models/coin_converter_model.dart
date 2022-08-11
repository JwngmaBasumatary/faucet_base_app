class CoinConverterModel {
  var inr;

  CoinConverterModel({
    this.inr,
  });

  CoinConverterModel.fromJson(Map<String, dynamic> json) {
    inr = json['INR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['INR'] = inr;
    return data;
  }
}
