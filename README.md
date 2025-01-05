# Object Lens

## Objective
A Flutter application that integrates object detection, real-time user guidance, and image capture. This document provides instructions to run the app, dependencies used and link of the app

---

## Features
1. **Object Detection**  
   - Real-time detection of objects using TensorFlow Lite.
   - Supports detection of selected objects like laptops, mobiles, and bottles.

2. **Auto-Capture**  
   - Automatically captures the image when the object is in the correct position.
   - Displays captured image and metadata (object type, date, and timestamp).

4. **Responsive UI**  
   - Works in both portrait and landscape orientations.
   - Clean, simple, and responsive design.

---

## How to Run
### Prerequisites
- Flutter SDK installed ([Installation Guide](https://flutter.dev/docs/get-started/install)).
- Compatible IDE (e.g., Android Studio, VS Code).
- Device or emulator with camera permissions.

### Steps
1. Clone the repository:
   git clone https://github.com/sabiq369/object-lens.git
   flutter pub get
   flutter run

## Dependencies
   - camera: For accessing and using the device camera.
   - tflite: TensorFlow Lite for real-time object detection.
   - get: For state management.

## Url
  - https://drive.google.com/drive/folders/1fLEyuC6S77Xj_TsLNwCLC8yyASYPkie4?usp=sharing
