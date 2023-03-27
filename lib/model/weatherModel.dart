class WeatherModel {
  num? id;
  num? temp;
  String? city;
  num? log, lat;

  WeatherModel({
    this.id,
    this.temp,
    this.city,
    this.lat,
    this.log,
  });

  WeatherModel.fromjson(Map<String, dynamic> map) {
    id = map['weather'][0]['id'];
    temp = map['main']['temp'];
    city = map['name'];
    lat = map['coord']['lat'];
    log = map['coord']['lon'];
    // description = map['coord']['lon'];
    //main = map['coord']['lat'];
    print(city);
    print('from model: ${map['coord']['lon']}');

    print('from model: ${map['coord']['lat']}');
    //   print(temp);
    //  // print('long:$description');
    //   print('lat:$main');
  }
}
