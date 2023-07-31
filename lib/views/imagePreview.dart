import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:snap_it/components/snap_tag.dart';
import 'package:snap_it/controllers/edit_controller.dart';
import 'package:snap_it/controllers/position_controller.dart';
import 'package:snap_it/views/cameraPage..dart';

import 'editPage.dart';

class ImagePreview extends StatelessWidget {
  ImagePreview({super.key, required this.byte_img});
  final ScreenshotController screenshotController =
      Get.put(ScreenshotController());
  final byte_img;
  EditController editController = Get.put(EditController());
  PositionController positionController = Get.put(PositionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview"),
        backgroundColor: Color(0xFF7e3ab5),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => {
            positionController.positionStream.resume(),
            positionController.setTime(),
            positionController.timestampTimer(),
            Get.back()
            },
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(EditBoard(
                  byte_img: byte_img,
                ));
              },
              icon: Icon(Icons.edit_location_outlined))
        ],
      ),
      body: Container(
        child: Screenshot(
          controller: screenshotController,
          child: Stack(children: [
            //  Center(child: AspectRatio(aspectRatio: 3/4,child: Image.file(File(byte_img.path),fit: BoxFit.cover,))),
            Center(
                child: ClipRRect(
                    child: SizedOverflowBox(
                        size: const Size(480, 600),
                        alignment: Alignment.center,
                        child: Image.file(
                          File(byte_img.path),
                          fit: BoxFit.cover,
                        )))),
            Tag(controller: positionController, top: 510.0, left: 5.0)
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final bytes = await screenshotController.capture();
          editController.saveimage(bytes);
          Get.to(() => ImagePreview(byte_img: bytes));
        },
        backgroundColor: Color(0xFF7e3ab5),
        child: Icon(Icons.save_alt_outlined),
      ),
    );
    ;
  }
}
