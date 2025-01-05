import 'package:assesment_object_lens/camera_screen/controller/camera_controller.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CameraScreen extends StatelessWidget {
  final String selectedObject;

  const CameraScreen({super.key, required this.selectedObject});

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(CameraScreenController(selectedObject: selectedObject));

    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        if (controller.onLoad.value) {
          return const Center(
            child: SizedBox(
              width: 50,
              // height: 15,
              child: LoadingIndicator(
                indicatorType: Indicator.ballPulse,
                strokeWidth: 4.0,
                colors: [Colors.deepPurple],
              ),
            ),
          );
        }

        return Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: CameraPreview(controller.cameraController),
            ),
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                color: Colors.black54,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          controller.detectedObject.value.isNotEmpty
                              ? 'Detected: ${controller.detectedObject.value}'
                              : 'Detecting $selectedObject ',
                          style: TextStyle(
                            fontFamily: 'Courier New',
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: 20,
                          height: 15,
                          child: LoadingIndicator(
                            indicatorType: Indicator.ballPulse,
                            strokeWidth: 4.0,
                            colors: [Colors.white],
                          ),
                        ),
                      ],
                    ),
                    if (controller.isMatched.value)
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Matched!',
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
