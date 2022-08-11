class CoingekoStatus {
  var currentPrice;
  var marketCap;
  var totalVolume;
  var high24h;
  var low24h;
  var priceChange24h;
  var priceChangePercentage24h;
  var circulatingSupply;
  var totalSupply;
  var lastUpdated;

  String? id;
  String? symbol;
  String? name;
  String? image;
  num? marketCapRank;
  num? marketCapChange24h;
  num? marketCapChangePercentage24h;
  num? ath;
  num? atl;
  bool isFavorite = false;

  CoingekoStatus(
      {this.currentPrice,
      this.id,
      this.symbol,
      this.name,
      this.image,
      this.marketCapRank,
      this.marketCapChange24h,
      this.marketCapChangePercentage24h,
      this.ath,
      this.atl,
      this.marketCap,
      this.totalVolume,
      this.high24h,
      this.low24h,
      this.priceChange24h,
      this.priceChangePercentage24h,
      this.circulatingSupply,
      this.totalSupply,
      this.lastUpdated});

  CoingekoStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    image = json['image'];
    marketCapRank = json['market_cap_rank'];
    marketCapChange24h = json['market_cap_change_24h'];
    marketCapChangePercentage24h = json['price_change_percentage_24h'];
    ath = json['ath'];
    atl = json['atl'];
    currentPrice = json['current_price'];
    marketCap = json['market_cap'];
    totalVolume = json['total_volume'];
    high24h = json['high_24h'];
    low24h = json['low_24h'];
    priceChange24h = json['price_change_24h'];
    priceChangePercentage24h = json['price_change_percentage_24h'];
    circulatingSupply = json['circulating_supply'];
    totalSupply = json['total_supply'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['symbol'] = symbol;
    data['name'] = name;
    data['image'] = image;
    data['market_cap_rank'] = marketCapRank;
    data['market_cap_change_24h'] = marketCapChange24h;
    data['price_change_percentage_24h'] = marketCapChangePercentage24h;
    data['ath'] = ath;
    data['atl'] = atl;
    data['current_price'] = currentPrice;
    data['market_cap'] = marketCap;
    data['total_volume'] = totalVolume;
    data['high_24h'] = high24h;
    data['low_24h'] = low24h;
    data['price_change_24h'] = priceChange24h;
    data['price_change_percentage_24h'] = priceChangePercentage24h;
    data['circulating_supply'] = circulatingSupply;
    data['total_supply'] = totalSupply;
    data['last_updated'] = lastUpdated;
    return data;
  }
}
