import 'package:intl/intl.dart';
import 'package:weather/model/weathermodel.dart';

class ForcastModel {
  num? temp;
  String? dateName;
  ForcastModel({required this.temp, required this.dateName});
  List<WeatherModel> historyWeather = [];

  ForcastModel.fromJson(Map<String?, dynamic> map) {
    // description: element['weather'][0]['description'],
    // id: element['weather'][0]['id'],
    //  main: element['weather'][0]['main'],
    temp = map['main']['temp'];
    dateName = DateFormat('E')
        .format(DateFormat("yyyy-mm-dd hh:mm:ss").parse(map['dt_txt']));
    //print(dateName);
    //print(temp);
  }
}
