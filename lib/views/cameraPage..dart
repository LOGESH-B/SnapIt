import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:snap_it/components/camera_lower_row.dart';
import 'package:snap_it/components/camera_upper_row.dart';
import 'package:snap_it/components/snap_tag.dart';
import 'package:snap_it/controllers/camera_controller.dart';
import 'package:snap_it/controllers/position_controller.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController? cameraController;
  late ScreenshotController screenshotController;
  CameraPageController cameraPageController = Get.put(CameraPageController());
  PositionController positionController = Get.put(PositionController());
  @override
  void initState() {
    //camera init
    cameraController = null;
    screenshotController = ScreenshotController();
    startCamera(cameraPageController.selectedcamera);

    super.initState();
  }

  //camera initilizing function
  Future<void> startCamera(direction) async {
    await cameraPageController.getCameras();
    cameraController = CameraController(
        cameraPageController.cameras[direction], ResolutionPreset.high,
        enableAudio: false);
    await cameraController!.initialize().then((value) {
      print("Camera initialized");
      if (mounted) {
        setState(() {});
      }
    }).catchError((Object e) {
      print(e);
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //get device ratio
    return cameraController != null
        ? SafeArea(
          child: Scaffold(
              backgroundColor: Colors.black,
              body: GetBuilder<PositionController>(builder: (controller) {
                List<Widget> contentp = [
                  CameraUpperComponents(cameraController: cameraController!,orientation: "pro",height: 75.0,width: double.infinity,),
                  Stack(
                    children: [
                      // SizedBox(height: ,),
                      Center(
                          child: ClipRRect(
                              child: SizedOverflowBox(
                                  size: const Size(480, 600),
                                  alignment: Alignment.center,
                                  child: CameraPreview(cameraController!)))),
                      Tag(controller: controller, top: Get.height*0.53, left: Get.width*0.01)
                    ],
                  ),
                  // Expanded(child: Container()),
        
                  CameraLowerComponents(
                      cameraController: cameraController!,
                      orientation: "pro",
                      startCamera: startCamera)
                ];
                List<Widget> contentl = [
                  CameraUpperComponents(cameraController: cameraController!,orientation: "land",height: double.infinity,width:75.0),
                  Stack(
                    children: [
                      // SizedBox(height: ,),
                      Center(
                          child: ClipRRect(
                              child: SizedOverflowBox(
                                  size: const Size(600, 480),
                                  alignment: Alignment.center,
                                  child: CameraPreview(cameraController!)))),
                      Tag(controller: controller, top: 225.0, left: 100.0)
                    ],
                  ),
                  // Expanded(child: Container()),
        
                  CameraLowerComponents(
                      cameraController: cameraController!,
                      orientation: "land",
                      startCamera: startCamera)
                ];
        
                return OrientationBuilder(builder: (_, orientation) {
                  if (orientation == Orientation.portrait) {
                    print('On p');
                    return Column(
                      children: contentp,
                    );
                  } // if orientation is portrait, show your portrait layout
                  else {
                    print('On l');
        
                    return Row(
                      children: contentl,
                    );
                  } // else show the landscape one
                });
              }),
            ),
        )
        : Scaffold(
            body: Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            ),
          );
    
  }
}
