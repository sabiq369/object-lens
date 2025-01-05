import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class CameraScreenController extends GetxController {
  CameraScreenController({required this.selectedObject});

  RxBool onLoad = true.obs;
  RxBool isLoading = true.obs;
  var detectedObject = ''.obs;
  late CameraController cameraController;
  late Interpreter interpreter;
  late List<String> classLabels;
  String selectedObject;
  final isMatched = false.obs;
  bool isProcessing = false;

  // Initialize the camera
  initializeCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    await cameraController.initialize();
    onLoad.value = false;
    startImageStream();
  }

  startImageStream() {
    cameraController.startImageStream((CameraImage image) async {
      if (isProcessing) return;
      isProcessing = true;
      runInference(image);
      isProcessing = false;
    });
  }

  void runInference(CameraImage cameraImage) {
    var inputImage = preprocessImage(cameraImage);
    var output = List.filled(1 * 10 * 4, 0).reshape([1, 10, 4]);
    interpreter.run(inputImage, output);
    processOutput(output);
  }

  Uint8List preprocessImage(CameraImage cameraImage) {
    // Convert YUV to RGB
    final width = cameraImage.width;
    final height = cameraImage.height;

    // Create an empty image with the correct dimensions
    img.Image rgbImage = img.Image(width, height);

    // Convert YUV to RGB
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final yIndex = y * cameraImage.planes[0].bytesPerRow + x;
        final uIndex = (y ~/ 2) * cameraImage.planes[1].bytesPerRow + (x ~/ 2);
        final vIndex = (y ~/ 2) * cameraImage.planes[2].bytesPerRow + (x ~/ 2);

        final yValue = cameraImage.planes[0].bytes[yIndex];
        final uValue = cameraImage.planes[1].bytes[uIndex] - 128;
        final vValue = cameraImage.planes[2].bytes[vIndex] - 128;

        final r = (yValue + 1.402 * vValue).clamp(0, 255).toInt();
        final g = (yValue - 0.344136 * uValue - 0.714136 * vValue)
            .clamp(0, 255)
            .toInt();
        final b = (yValue + 1.772 * uValue).clamp(0, 255).toInt();

        rgbImage.setPixel(x, y, img.getColor(r, g, b));
      }
    }

    img.Image resizedImage = img.copyResize(rgbImage, width: 3020, height: 300);

    return Uint8List.fromList(resizedImage.getBytes());
  }

  void processOutput(List<dynamic> output) {
    detectedObject.value = '';
    for (var detection in output[0]) {
      final classId = detection[0];
      final confidence = detection[1];
      if (confidence > 0.5) {
        String classLabel = classLabels[classId.toInt()];
        detectedObject.value =
            '$classLabel: ${(confidence * 100).toStringAsFixed(1)}%\n';
      }
    }
  }

  loadLabels() async {
    try {
      final labelsData = await rootBundle.loadString('assets/labels.txt');
      classLabels = labelsData.split('\n');
    } catch (e) {
      Get.snackbar("Error", "Failed to load labels: $e");
    }
  }

  loadModel() async {
    try {
      interpreter =
          await Interpreter.fromAsset('assets/object_detection.tflite');
    } catch (e) {
      Get.snackbar("Error", "Failed to load model: $e");
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await loadModel();
    await loadLabels();
    await initializeCamera();
  }

  @override
  void onClose() {
    cameraController.stopImageStream();
    cameraController.dispose();
    interpreter.close();
    super.onClose();
  }
}
