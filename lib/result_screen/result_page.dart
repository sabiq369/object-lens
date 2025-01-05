import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final detectedObjectDetails = Get.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detected Object Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detected Object: ${detectedObjectDetails['name']}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Image.asset(
              detectedObjectDetails['image'],
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Detected at: ${detectedObjectDetails['time']}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
