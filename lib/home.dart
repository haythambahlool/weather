import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/city_screen.dart';
import 'package:weather/const.dart';
import 'package:weather/get_location.dart';
import 'package:weather/model/fetchApi.dart';
import 'package:weather/model/forcastModel.dart';
import 'package:weather/model/weathermodel.dart';
import 'model/location.dart';

class home extends StatefulWidget {
  home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final ImageProvider _assetImage = const AssetImage('images/10.png');

  final ImageProvider _networkImage =
      const NetworkImage("https://source.unsplash.com/random/?snowy");

  bool _checkLoaded = true;
  Fetchweathers currentweather = Fetchweathers();
  FetchApi historyweather = FetchApi();
  location loc = location();

  getLocation() async {
    await loc.getCurrentLocation();
    print('longitude:${loc.longitude}  latitude:${loc.latitude}');
    print('before await');
    await Future.delayed(const Duration(milliseconds: 5000));
    print('after await');
    setState(() {});
  }

  double? log;
  double? lat;
  @override
  void initState() {
    getLocation();

    _networkImage.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo info, bool _) {
          setState(
            () {
              _checkLoaded = false;
              print('done...');
            },
          );
        },
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<WeatherModel>(
          future: currentweather.fetchweather(
            lat: lat == null ? 51.5085 : lat,
            long: log == null ? -0.1257 : log,
          ),
          builder: (context, snapshot) {
            // WeatherModel historyweather = snapshot.data!;
            if (currentweather.end = false) {
              return Container(
                constraints: BoxConstraints.expand(),
                color: Colors.white,
                child: Center(
                  child: SpinKitSpinningLines(
                    color: Colors.black54,
                    size: 50.0,
                  ),
                ),
              );
            } else if (snapshot.hasData) {
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        filterQuality: FilterQuality.high,
                        image: _assetImage
                        //NetworkImage('https://source.unsplash.com/random/?snowy')
                        ,
                        fit: BoxFit.cover,
                      ),
                    ),
                    constraints: const BoxConstraints.expand(),
                  ),
                  AnimatedOpacity(
                    opacity: _checkLoaded ? 0 : 1,
                    duration: Duration(milliseconds: 800),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: _networkImage
                          //NetworkImage('https://source.unsplash.com/random/?snowy')
                          ,
                          fit: BoxFit.cover,
                        ),
                      ),
                      constraints: const BoxConstraints.expand(),
                    ),
                  ),
                  SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  lat = loc.latitude;
                                  log = loc.longitude;
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.near_me,
                                  size: 40,
                                  color: _checkLoaded
                                      ? kPrimaryColor
                                      : kPrimaryColor2,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CityScreen(),
                                    ),
                                  ).then((value) {
                                    setState(() {
                                      [
                                        lat = (value as Map)['lat'],
                                        log = (value as Map)['log'],
                                      ];
                                    });
                                  });
                                  ;
                                },
                                child: Icon(
                                  Icons.location_city,
                                  size: 40,
                                  color: _checkLoaded
                                      ? kPrimaryColor
                                      : kPrimaryColor2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              // gradient: RadialGradient(
                              //   colors: [
                              //     Colors.black.withOpacity(0.3),
                              //     Colors.black.withOpacity(0.25),
                              //     Colors.black.withOpacity(0.2),
                              //     Colors.black.withOpacity(0.15),
                              //     Colors.black.withOpacity(0.1),
                              //     Colors.black.withOpacity(0),
                              //   ],
                              //   // begin: Alignment.center,
                              //   // end: Alignment.center,
                              // ),
                              ),
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.cloudSun,
                                size: 75,
                                color: _checkLoaded
                                    ? kPrimaryColor
                                    : kPrimaryColor2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  snapshot.data! == null
                                      ? const SpinKitRipple(
                                          color: Colors.white,
                                          size: 25.0,
                                        )
                                      : Text(
                                          '${snapshot.data!.temp!.round()}',
                                          // '{historyweather == null ? null : historyweather[0].temp}',

                                          // historyweather[0].temp;

                                          style: TextStyle(
                                            fontSize: 75,
                                            fontWeight: FontWeight.w300,
                                            color: _checkLoaded
                                                ? kPrimaryColor
                                                : kPrimaryColor2,
                                          ),
                                        ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 4,
                                              color: _checkLoaded
                                                  ? kPrimaryColor
                                                  : kPrimaryColor2,
                                            ),
                                            shape: BoxShape.circle),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height: 3,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            color: _checkLoaded
                                                ? kPrimaryColor
                                                : kPrimaryColor2,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      Text(
                                        'now',
                                        style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Spartan MB',
                                          letterSpacing: 5,
                                          color: _checkLoaded
                                              ? kPrimaryColor
                                              : kPrimaryColor2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              snapshot.data! == null
                                  ? const SpinKitThreeBounce(
                                      color: Colors.white,
                                      size: 25.0,
                                    )
                                  : Text(
                                      '${snapshot.data!.city}',
                                      // '{historyweather == null ? null : historyweather[0].city}',
                                      style: TextStyle(
                                        fontSize: 35.0,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'Spartan MB',
                                        letterSpacing: 5,
                                        color: _checkLoaded
                                            ? kPrimaryColor
                                            : kPrimaryColor2,
                                      ),
                                    ),
                              SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 150,
                        ),
                        // Text(
                        //   'It\'s 🥶 in Gaza! Dress 🧤🧣',
                        //   style: TextStyle(
                        //     fontSize: 30,
                        //     fontWeight: FontWeight.w500,
                        //     color: Colors.white,
                        //   ),
                        // ),

                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35),
                                topRight: Radius.circular(35),
                              ),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                                child: Container(
                                  height: 185,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(35),
                                      topRight: Radius.circular(35),
                                    ),
                                    border: Border.all(
                                      color: kPrimaryColor,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              // left: 20,
                              top: 25,
                              child: Container(
                                height: 140,
                                width: 400,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: dayscard(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Container(
              constraints: BoxConstraints.expand(),
              color: Colors.white,
              child: Center(
                child: SpinKitSpinningLines(
                  color: Colors.black54,
                  size: 50.0,
                ),
              ),
            );
          }),
    );
  }

  Widget dayscard() {
    return FutureBuilder(
        future: historyweather.fetchforcast(
          lat: lat == null ? 51.5085 : lat,
          long: log == null ? -0.1257 : log,
        ),
        builder: (context, snapshot) {
          if (historyweather.end == false) {
            print(' if');
            return const Center(
              child: SpinKitSpinningLines(
                color: Colors.white,
                size: 50.0,
              ),
            );
          } else if (historyweather.end == true) {
            print('else if');
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    historyweather.end == false ? 0 : snapshot.data!.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: 55,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            height: 140,
                            width: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: snapshot.data![index].temp == null
                                ? const SpinKitSpinningLines(
                                    color: Colors.black54,
                                    size: 50.0,
                                  )
                                : Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      FittedBox(
                                        child: Text(
                                          '${snapshot.data![index].dateName}',
                                          style: TextStyle(
                                            overflow: TextOverflow.fade,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                      const Image(
                                        height: 35,
                                        image: AssetImage('images/2.png'),
                                      ),
                                      Text(
                                        '${snapshot.data![index].temp!.round()}°',
                                        style: const TextStyle(fontSize: 20),
                                      )
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ),
                  );
                }));
          } else {
            print('else ');
            return const Center(
              child: SpinKitSpinningLines(
                color: Colors.black54,
                size: 50.0,
              ),
            );
          }
        });
  }
}

// class DaysCard extends StatelessWidget {
//   DaysCard({Key? key, required this.lat, required this.long}) : super(key: key);
//   double? long;
//   double? lat;
//   FetchApi historyweather = FetchApi();
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: historyweather.fetchforcast(lat: 51.5085, long: -0.1257),
//         builder: (context, snapshot) {
//           if (historyweather.end == false) {
//             print(' if');
//             return const Center(
//               child: SpinKitSpinningLines(
//                 color: Colors.black54,
//                 size: 50.0,
//               ),
//             );
//           } else if (historyweather.end == true) {
//             print('else if');
//             return ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount:
//                     historyweather.end == false ? 0 : snapshot.data!.length,
//                 itemBuilder: ((context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Container(
//                       width: 55,
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.4),
//                         borderRadius: BorderRadius.circular(40),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(40),
//                         child: BackdropFilter(
//                           filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                               vertical: 10,
//                             ),
//                             height: 140,
//                             width: 60,
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: Colors.white,
//                                 width: 0.5,
//                               ),
//                               borderRadius: BorderRadius.circular(40),
//                             ),
//                             child: snapshot.data![index].temp == null
//                                 ? const SpinKitSpinningLines(
//                                     color: Colors.black54,
//                                     size: 50.0,
//                                   )
//                                 : Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceAround,
//                                     children: [
//                                       FittedBox(
//                                         child: Text(
//                                           '${snapshot.data![index].dateName}',
//                                           style: TextStyle(
//                                             overflow: TextOverflow.fade,
//                                             fontSize: 17,
//                                             fontWeight: FontWeight.w300,
//                                           ),
//                                         ),
//                                       ),
//                                       const Image(
//                                         height: 35,
//                                         image: AssetImage('images/2.png'),
//                                       ),
//                                       Text(
//                                         '${snapshot.data![index].temp!.round()}°',
//                                         style: const TextStyle(fontSize: 20),
//                                       )
//                                     ],
//                                   ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 }));
//           } else {
//             print('else ');
//             return const Center(
//               child: SpinKitSpinningLines(
//                 color: Colors.black54,
//                 size: 50.0,
//               ),
//             );
//           }
//         });
//   }
// }
