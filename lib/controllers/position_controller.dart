import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PositionController extends GetxController {
  String? currentAddress;
  //  currentAddress;
  var parsedAddress;
  Position? currentPosition;
  bool timer = true;
  var timestamp;
  bool hasPermission = false;
  late StreamSubscription<Position> positionStream;

  @override
  void onInit() {
    super.onInit();
    timestampTimer(); 
    stream();
  }


  timestampTimer() {
    print("timer");
    Timer.periodic(
        Duration(seconds: 1),
        (Timer t) => {
              if (!timer) {t.cancel()} else currentTimestamp()
            });
  }

  setTime() {
    timer = !timer;
    update();
  }

  currentTimestamp() {
    print(Orientation.landscape);
    var t = DateTime.now();
    var GMT = DateTime.now().timeZoneOffset.toString();
    var isnegative = DateTime.now().timeZoneOffset.isNegative
        ? GMT.substring(0, 4)
        : "+" + GMT.substring(0, 4);
    timestamp =
        DateFormat('dd/MM/yyyy KK:mm:ss a').format(t) + " GMT " + isnegative;
    update();
  }

  stream() {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 1,
    );
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      if (position != null) {
        print(position.latitude);
        _getAddressFromLatLng(position);
      }
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    print("on");
    print(position);
    currentPosition = position;
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress = '${place}';
      parsedAddress = tojsonaddress(currentAddress);
      print(parsedAddress);
      update();
    }).catchError((e) {
      debugPrint(e);
    });
  }

  tojsonaddress(address) {
    String name = address;
    List<String> str = name.replaceAll("{", "").replaceAll("}", "").split(",");
    Map<String, dynamic> result = {};
    for (int i = 0; i < str.length; i++) {
      List<String> s = str[i].split(":");
      result.putIfAbsent(s[0].trim(), () => s[1].trim());
    }
    return result;
  }
}
