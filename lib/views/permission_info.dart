import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_it/controllers/permission_controller.dart';

class PermissionInfo extends StatelessWidget {
  PermissionInfo({super.key});
  PermissionInfoController permissionInfoController =
      Get.put(PermissionInfoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage("assets/images/snapit-logo.png",),height: Get.height*0.15),
              Text("SNapIt",style: TextStyle(fontSize: 35.0,fontWeight: FontWeight.bold,letterSpacing: 2),),
              SizedBox(height: Get.height*0.2,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Please Accept the required permissions to take the snap",textAlign: TextAlign.center, style: TextStyle(),),
              ),
              SizedBox(height: Get.height*0.05,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF598ae4)),
                  onPressed: () {
                    permissionInfoController.askPermissions();
                  },
                  child: Text("Explore"))
            ],
          ),
        ),
      ),
    );
  }
}
