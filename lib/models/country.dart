class Country {
  var status;
  var country;
  var countryCode;
  var region;
  var regionName;
  var city;
  var zip;
  var lat;
  var lon;
  var timezone;
  var isp;
  var org;
  var as;
  var query;

  Country(
      {required this.status,
      required this.country,
      required this.countryCode,
      required this.region,
      required this.regionName,
      required this.city,
      required this.zip,
      required this.lat,
      required this.lon,
      required this.timezone,
      required this.isp,
      required this.org,
      required this.as,
      required this.query});

  Country.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    country = json['country'];
    countryCode = json['countryCode'];
    region = json['region'];
    regionName = json['regionName'];
    city = json['city'];
    zip = json['zip'];
    lat = json['lat'];
    lon = json['lon'];
    timezone = json['timezone'];
    isp = json['isp'];
    org = json['org'];
    as = json['as'];
    query = json['query'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['country'] = country;
    data['countryCode'] = countryCode;
    data['region'] = region;
    data['regionName'] = regionName;
    data['city'] = city;
    data['zip'] = zip;
    data['lat'] = lat;
    data['lon'] = lon;
    data['timezone'] = timezone;
    data['isp'] = isp;
    data['org'] = org;
    data['as'] = as;
    data['query'] = query;
    return data;
  }
}
