


import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:native_exif/native_exif.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:snap_it/controllers/position_controller.dart';

class EditController extends GetxController {
  PositionController positionController=Get.put(PositionController());
  Uint8List? bytes;
  var position = Offset(0, 0);
  late ScreenshotController screenshotController;
  File pickedimage = File("");

  onInit() {
    screenshotController = ScreenshotController();
  }

  cameraImage(bytes, imgbytes) {
    Screenshot(child: Stack(children: [
      Image.memory(imgbytes),
      
    ]), controller: screenshotController);
  }

  setimage(pickedimg) {
    pickedimage = pickedimg;
    update();
  }

  updateposition(details) {
    position = details;
    update();
  }

  Future saveimage(bytes) async {
    this.bytes = bytes;
    if (await _requestPermission(Permission.storage) &&
        await _requestPermission(Permission.manageExternalStorage)) {
      Directory? directory;
      directory = await getExternalStorageDirectory();
      String newPath = "";
      print(directory);
      List<String> paths = directory!.path.split("/");
      print(paths);
      for (int x = 1; x < paths.length; x++) {
        String folder = paths[x];
        if (folder != "Android") {
          newPath += "/" + folder;
        }
      }
      newPath = newPath + "/Geotag";
      directory = Directory(newPath);
      print("kii");
      print(directory.path);
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      File saveFile =
          File(directory.path + "/${DateTime.now().millisecond}.png");
      await saveFile.writeAsBytes(bytes);
      print(directory);
      print(saveFile.path);
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy:MM:dd HH:mm:ss').format(now);
      print(formattedDate);
      final exif = await Exif.fromPath(saveFile.path);
      await exif.writeAttributes({"GPSLatitude": positionController.currentPosition!.latitude.toString(), "GPSLongitude": positionController.currentPosition!.longitude.toString()});
      await exif.writeAttributes({"DateTimeOriginal":formattedDate.toString(), "TAG_DATETIME": formattedDate.toString()});
     
      print(await exif.getAttributes());
      await exif.close();
      update();
      print("downloaded");
      Get.snackbar("Downloaded", 'Downloaded in your local Storage');
    } else {
      Get.snackbar("no Permission", "Permisson Denined");
      if(await _requestPermission(Permission.storage) &&
        await _requestPermission(Permission.manageExternalStorage)){
          saveimage(bytes);
        }
    }
    update();
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }


  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {      
      Get.snackbar("Access Denied",
          "Location services are disabled. Please enable the services");

      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar("Access Denied", "Location Permission Denined");
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar("Access Denied",
          "Location permissions are permanently denied, we cannot request permissions.");
      return false;
    }
    return true;
  }

}
