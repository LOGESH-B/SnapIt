import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_it/controllers/camera_controller.dart';
import 'package:snap_it/controllers/position_controller.dart';
import 'package:snap_it/views/imagePreview.dart';
import '../controllers/camera_lower_controller.dart';

class CameraLowerComponents extends StatelessWidget {
  CameraLowerComponents(
      {super.key, required this.cameraController, required this.startCamera,required this.orientation});
      final orientation;
  final CameraController cameraController;
  final startCamera;
  final cameraLowerController = Get.put(CameraLowerController());
  final CameraPageController cameraPageController = Get.find();
  final PositionController positionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return orientation=="pro"? Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.aspect_ratio_outlined,
                color: Colors.white,
              )),
          IconButton(
            iconSize: 55.0,
              onPressed: () async {
                positionController.setTime();
                positionController.positionStream.pause();
                await cameraController
                    .takePicture()
                    .then((value) => Get.to(() => ImagePreview(byte_img: value)));
              },
              icon: Icon(
                Icons.camera_outlined,
                color: Colors.white,
                
              )),
          IconButton(
              onPressed: () {
                cameraPageController.selectedcamera != 1
                    ? cameraPageController.setCamera(1)
                    : cameraPageController.setCamera(-1);
                print(cameraPageController.selectedCameradescripption);
                startCamera(cameraPageController.selectedcamera);
              },
              icon: Icon(
                Icons.cameraswitch_outlined,
                color: Colors.white,
              ))
        ],
      ),
    ):Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.aspect_ratio_outlined,
                color: Colors.white,
              )),
          IconButton(
            iconSize: 55.0,
              onPressed: () async {
                positionController.setTime();
                positionController.positionStream.pause();
                await cameraController
                    .takePicture()
                    .then((value) => Get.to(() => ImagePreview(byte_img: value)));
              },
              icon: Icon(
                Icons.camera_outlined,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                cameraPageController.selectedcamera != 1
                    ? cameraPageController.setCamera(1)
                    : cameraPageController.setCamera(-1);
                print(cameraPageController.selectedCameradescripption);
                startCamera(cameraPageController.selectedcamera);
              },
              icon: Icon(
                Icons.cameraswitch_outlined,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
