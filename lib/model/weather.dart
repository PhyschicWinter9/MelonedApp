class Weather {
  double? lat;
  double? lon;
  String? decoration;
  String? cityname;
  double? temp;
  int? humidity;
  double? feels_like;
  int? pressure;

  Weather({
    this.lat,
    this.lon,
    this.decoration,
    this.cityname,
    this.temp,
    this.humidity,
    this.feels_like,
    this.pressure,
  });

  Weather.fromJson(Map<String, dynamic> json) {
    lat = json['coord']['lat'];
    lon = json['coord']['lon'];
    decoration = json['weather'][0]['description'];
    cityname = json['name'];
    temp = json['main']['temp'];
    humidity = json['main']['humidity'];
    feels_like = json['main']['feels_like'];
    pressure = json['main']['pressure'];
  }
}
