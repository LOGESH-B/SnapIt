import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:snap_it/views/home.dart';

class PermissionInfoController extends GetxController {
  
  bool locationP = false;
  bool storageP = false;
  bool manageExternalStorageP = false;
  bool cameraP = false;

  @override
  void onInit() {
    // TODO: implement onInit
    askPermissions();
    super.onInit();
  }

  askPermissions() async {
  // Request permissions simultaneously
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.storage,
    // Permission.manageExternalStorage,
    Permission.camera,
  ].request();

  // Check the status of each permission
  var locationP = statuses[Permission.location];
  var storageP = statuses[Permission.storage];
  // var manageExternalStorageP = statuses[Permission.manageExternalStorage];
  var cameraP = statuses[Permission.camera];

  print(locationP);
  print(storageP);
  print(manageExternalStorageP);
  print(cameraP);

  if (locationP == PermissionStatus.granted &&
      // manageExternalStorageP == PermissionStatus.granted &&
      storageP == PermissionStatus.granted &&
      cameraP == PermissionStatus.granted) {
    Get.off(() => Home());
  } else {
    Get.snackbar("Permisson Handled failed", "Permissions requested are not granted");
  }
}

  // askPermissions() async {
  //   locationP = await Permission.location.isGranted;
  //   storageP = await Permission.storage.isGranted;
  //   manageExternalStorageP = await Permission.manageExternalStorage.isGranted;
  //   cameraP = await Permission.camera.isGranted;
  //       print(locationP);
  //   print(storageP);
  //   print(manageExternalStorageP);
  //   print(cameraP);
  //   update();

  //   if (locationP==true && manageExternalStorageP==true && cameraP==true) {
  //     Get.off(() => Home());
  //   }else{
  //     !locationP?locationP=await ask(await Permission.location):"";
  //     !storageP?storageP=await ask(await Permission.storage):"";
  //     !manageExternalStorageP?manageExternalStorageP=await ask(await Permission.manageExternalStorage):"";
  //     !cameraP?cameraP=await ask(await Permission.camera):"";
  //     update();
    
  //     // askPermissions();
      
  //   }


  //   if (await Permission.location.isPermanentlyDenied ||
  //       await Permission.storage.isPermanentlyDenied ||
  //       await Permission.manageExternalStorage.isPermanentlyDenied ||
  //       await Permission.camera.isPermanentlyDenied) {
  //     openAppSettings();
      
  //   }

  // }


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
