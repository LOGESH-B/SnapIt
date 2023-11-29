import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:snap_it/views/home.dart';
import 'package:snap_it/views/permission_info.dart';

void main() async{
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your applica  tion.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SnapIt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:PermissionInfo(),
    );
  }
}
