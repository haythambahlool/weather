import 'package:flutter/material.dart';
import 'package:weather/model/fetchApi.dart';
import 'package:weather/model/weatherModel.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  CityScreenState createState() => CityScreenState();
}

class CityScreenState extends State<CityScreen> {
  getcity(city) async {
    if (city == null) {
      _validate = true;
    } else {
      Fetchcityweathers gcity = Fetchcityweathers();
      var weather = await gcity.fetchcityweather(city: city!);
      if (weather == null) {
        print('false null');
        setState(() {
          _validate = false;
          city = null;
          citycon.clear();
        });
      } else {
        print(weather);
        citycon.clear();
        city = null;
        Navigator.pop(context, {'lat': weather.lat, 'log': weather.log});
      }
    }
  }

  TextEditingController citycon = TextEditingController();
  String? city;
  bool? _validate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/10.png'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 25.0,
                    color: Color.fromARGB(255, 231, 75, 127),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                //child: null,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  onChanged: (value) => city = value,
                  controller: citycon,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      errorText: _validate == true
                          ? 'You Should Enter the City name'
                          : _validate == false
                              ? 'enter Right city'
                              : null,
                      labelText: "Enter The city",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      )),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 231, 75, 127),
                  elevation: 0.0,
                ),
                onPressed: () {
                  setState(() {
                    FocusManager.instance.primaryFocus?.unfocus();
                    getcity(city);
                  });
                },
                child: const Text(
                  'Get Weather',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
