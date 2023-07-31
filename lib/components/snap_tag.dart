

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Tag extends StatelessWidget {
  const Tag({super.key,required this.controller,required this.top,required this.left});
  final controller;
  final top;
  final left;
  @override
  Widget build(BuildContext context) {
    return Positioned(
                        top: top,
                        left: left,
                        child: Padding(
                          padding: const EdgeInsets.all(.0),
                          child: Center(
                            child: Container(
                              height: 150.0,
                              width: 400.0,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 1.0),
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.black.withOpacity(0.5)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.parsedAddress != null
                                        ? "${controller.parsedAddress["Name"]},${controller.parsedAddress["Locality"]} ${controller.parsedAddress["Subadministrative area"]}\n${controller.parsedAddress["Administrative area"]} - ${controller.parsedAddress["Postal code"]}\n"
                                        : "",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller.parsedAddress != null
                                              ? "Lat: ${controller.currentPosition?.latitude}°\nLong: ${controller.currentPosition?.longitude}°"
                                              : "",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            controller.parsedAddress != null
                                                ? '${controller.timestamp}\n(${controller.parsedAddress["Name"]})'
                                                : "",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
  }
}