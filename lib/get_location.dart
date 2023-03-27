import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/home.dart';
import 'package:weather/model/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/model/forcastModel.dart';

import 'model/fetchApi.dart';

class get_location extends StatefulWidget {
  const get_location({super.key});

  @override
  State<get_location> createState() => _get_locationState();
}

class _get_locationState extends State<get_location>
    with TickerProviderStateMixin {
  void autoNavigation() async {
    // you can change delay here
    await Future.delayed(const Duration(milliseconds: 5000));

    print('nav');
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => home(),
        ));
  }

  // late Future<List<ForcastModel>> ww;
  // fetch() async {
  //   fetchweather = FetchApi();
  //   ww = fetchweather!.fetchforcast();
  // }

  static FetchApi? fetchweather;
  @override
  void initState() {
    // TODO: implement initState
    //fetch();

    autoNavigation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: SpinKitSpinningLines(
            color: Colors.black54,
            size: 50.0,
          ),
        ),
      ),
    );
  }
}
