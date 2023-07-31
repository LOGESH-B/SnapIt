import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:snap_it/views/home.dart';

class PermissionInfoController extends GetxController {
  bool locationP = false;
  bool storageP = false;
  bool manageExternalStorageP = false;
  bool cameraP = false;

  askPermissions() async {
    locationP = await Permission.location.isGranted;
    storageP = await Permission.storage.isGranted;
    manageExternalStorageP = await Permission.manageExternalStorage.isGranted;
    cameraP = await Permission.camera.isGranted;
        print(locationP);
    print(storageP);
    print(manageExternalStorageP);
    print(cameraP);
    update();

    if (locationP==true && storageP==true && manageExternalStorageP==true && cameraP==true) {
      Get.off(() => Home());
    }else{
      !locationP?locationP=await ask(await Permission.location):"";
      !storageP?storageP=await ask(await Permission.storage):"";
      !manageExternalStorageP?manageExternalStorageP=await ask(await Permission.manageExternalStorage):"";
      !cameraP?cameraP=await ask(await Permission.camera):"";
      update();
    
      // askPermissions();
      
    }


    if (await Permission.location.isPermanentlyDenied ||
        await Permission.storage.isPermanentlyDenied ||
        await Permission.manageExternalStorage.isPermanentlyDenied ||
        await Permission.camera.isPermanentlyDenied) {
      openAppSettings();
      
    }

  }
  ask(Permission p)async {
    if(await p.request().isGranted){
      
    print("hii");
      return true;
    }
    else{
      if(await p.isPermanentlyDenied){
        openAppSettings();
      }
    }

  }
}
