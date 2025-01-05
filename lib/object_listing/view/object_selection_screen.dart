import 'package:assesment_object_lens/camera_screen/view/camera_screen.dart';
import 'package:assesment_object_lens/object_listing/model/object_list.dart';
import 'package:assesment_object_lens/utils/common_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ObjectSelectionScreen extends StatelessWidget {
  const ObjectSelectionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Choose an Object',
          style: TextStyle(
            fontFamily: 'Times New Roman',
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: objects.length,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              try {
                PermissionStatus status = await Permission.camera.request();
                PermissionStatus microPhone =
                    await Permission.microphone.request();
                if (!status.isGranted || !microPhone.isGranted) {
                  showPermissionDialog();
                  return;
                } else {
                  Get.dialog(AlertDialog(
                    backgroundColor: Colors.transparent,
                    actions: [
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            Get.back();
                            Get.to(
                                () => CameraScreen(
                                    selectedObject: objects[index]),
                                transition: Transition.fadeIn);
                          },
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                              fontFamily: 'Times New Roman',
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    ],
                  ));
                }
              } catch (e) {}
            },
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black54,
                      Colors.deepPurple.shade800,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 14.0,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontFamily: 'Times New Roman',
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Text(
                        objects[index],
                        style: TextStyle(
                          fontFamily: 'Courier New',
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white.withOpacity(0.8),
                      size: 20.0,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
