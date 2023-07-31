

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:snap_it/controllers/camera_upper_controller.dart';

class CameraUpperComponents extends StatelessWidget {
  CameraUpperComponents({super.key,required this.cameraController,required this.orientation,required this.height,required this.width});
  final CameraController cameraController;
  final orientation;
  final height;
  final width;
  final  cameraUpperController = Get.put(CameraUpperController());
  
  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
                    height: height,
                    width: width,
                    child:orientation=="land"? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back,color: Colors.white,)),
                        IconButton(
                            onPressed: () {
                              !cameraUpperController.flash
                                  ? cameraController
                                      .setFlashMode(FlashMode.torch)
                                  : cameraController
                                      .setFlashMode(FlashMode.off);
                              cameraUpperController.setFlash();
                            },
                            icon: Icon(
                              cameraUpperController.flash ? Icons.flash_on : Icons.flash_off,
                              color: Colors.white,
                            ))
                      ],
                    )
                 :Row(
                  
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back,color:Colors.white,)),
                        IconButton(
                            onPressed: () {
                              !cameraUpperController.flash
                                  ? cameraController
                                      .setFlashMode(FlashMode.torch)
                                  : cameraController
                                      .setFlashMode(FlashMode.off);
                              cameraUpperController.setFlash();
                            },
                            icon: Icon(
                              cameraUpperController.flash ? Icons.flash_on : Icons.flash_off,
                              color: Colors.white,
                            ))
                      ],
                    ),
                   );
  }
}