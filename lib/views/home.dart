import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_it/views/cameraPage..dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SnapIt"),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child:
              ElevatedButton(onPressed: () => Get.to(CameraPage()), child: Text("Take Your Tag")),
        ),
      ),
    );
  }
}
