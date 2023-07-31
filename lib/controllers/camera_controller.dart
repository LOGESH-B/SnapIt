

import 'package:camera/camera.dart';
import 'package:get/get.dart';

class CameraPageController extends GetxController{
  
  int selectedcamera = 0;
  late List<CameraDescription> cameras;
  late CameraDescription selectedCameradescripption;

  getCameras()async{
    cameras = await availableCameras();
    update();
  }

  setCamera(int value){
    selectedcamera+=value;
    selectedCameradescripption=cameras[selectedcamera];
    update();
  }



}