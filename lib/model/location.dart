import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class location {
  double? longitude;
  double? latitude;

  Future<void> getCurrentLocation() async {
    // double long;
    //double lat;
    Position position;
    LocationPermission permission;
    await Geolocator.requestPermission();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low)
          .then((v) {
        longitude = v.longitude;
        latitude = v.latitude;
      });
    }
  }
}
