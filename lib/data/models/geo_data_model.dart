class GeoData {
  String? name;
  double? lat;
  double? lon;
  String? country;
  String? state;

  @override
  String toString() {
    return 'GeoData{name: $name, lat: $lat, lon: $lon, country: $country, state: $state}';
  }

  GeoData({this.name, this.lat, this.lon, this.country, this.state});

  GeoData.fromJson(List<dynamic> json) {
    name = json[0]['name'];
    lat = json[0]['lat'];
    lon = json[0]['lon'];
    country = json[0]['country'];
    state = json[0]['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['lat'] = lat;
    data['lon'] = lon;
    data['country'] = country;
    data['state'] = state;
    return data;
  }
}
