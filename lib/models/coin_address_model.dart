class CoinAddressModel {
  String? coinbase;
  String? faucetpay;
  String? binance;

  CoinAddressModel({this.coinbase, this.faucetpay, this.binance});

  CoinAddressModel.fromJson(Map<String, dynamic> json) {
    coinbase = json['coinbase'];
    faucetpay = json['faucetpay'];
    binance = json['binance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['coinbase'] = coinbase;
    data['faucetpay'] = faucetpay;
    data['binance'] = binance;

    return data;
  }
}
