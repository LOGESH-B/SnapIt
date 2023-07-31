

import 'package:get/get.dart';

class CameraUpperController extends GetxController{
    bool flash = false;
    
    setFlash(){
      flash=!flash;
      update();
    }
    
}