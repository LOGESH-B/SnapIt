


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_it/controllers/permission_controller.dart';

class PermissionInfo extends StatelessWidget {
  PermissionInfo({super.key});
  PermissionInfoController permissionInfoController=Get.put(PermissionInfoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        child: Column(
          children: [
            Text("1. Storage Permission is required to store your tagged image."),
            Text("2. Storage Permission is required to store your tagged image."),
            Text("3. Storage Permission is required to store your tagged image."),
            Text("Note: You must give Permission to all these required permissions to enjoy the service"),
            ElevatedButton(onPressed: (){permissionInfoController.askPermissions();}, child: Text("Explore"))
          ],
        ),
      ),
    );
  }
}