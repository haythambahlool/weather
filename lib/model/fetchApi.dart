import 'package:http/http.dart' as http;
import 'package:weather/model/forcastModel.dart';
import 'dart:convert';
import 'package:weather/model/weathermodel.dart';

class FetchApi {
  bool end = false;
  Future<List<ForcastModel>> fetchforcast(
      {required double? long, required double? lat}) async {
    print('start');
    http.Response response = await http.get(
      Uri.parse(
        long == null
            ? "https://api.openweathermap.org/data/2.5/forecast?q=paris&units=metric&appid=42ca31d2389e2a356506393bcbd32acb"
            : "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&units=metric&appid=42ca31d2389e2a356506393bcbd32acb",
      ),
    );
    List<ForcastModel> weathers = [];
    Future<List<ForcastModel>> reweather() async {
      var body = await jsonDecode(response.body);
      for (int i = 0; i < 40; i += 8) {
        weathers.add(ForcastModel.fromJson(body['list'][i]));
      }

      return weathers;
    }

    end = true;

    return reweather();
  }
}

class Fetchweathers {
  bool end = false;
  Future<WeatherModel> fetchweather({
    required double? long,
    required double? lat,
  }) async {
    WeatherModel body;

    http.Response response = await http.get(
      Uri.parse(
        long == null
            ? "https://api.openweathermap.org/data/2.5/weather?q=paris&units=metric&appid=42ca31d2389e2a356506393bcbd32acb"
            : "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&units=metric&appid=42ca31d2389e2a356506393bcbd32acb",
      ),
    );

    body = WeatherModel.fromjson(jsonDecode(response.body));
    end = true;
    return body;
  }
}

class Fetchcityweathers {
  //bool end = false;
  Future<WeatherModel?> fetchcityweather({
    required String city,
  }) async {
    WeatherModel body;

    http.Response response = await http.get(
      Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=42ca31d2389e2a356506393bcbd32acb",
      ),
    );
    if (response.statusCode == 200) {
      body = WeatherModel.fromjson(jsonDecode(response.body));
      //end = true;
      return body;
    } else {
      return null;
    }
  }
}
