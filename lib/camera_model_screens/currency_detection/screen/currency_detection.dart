import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'dart:async';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:flutter_tts/flutter_tts.dart';


late List<CameraDescription> camerass;
TTS tts = TTS();

class CurrencyDetection extends StatefulWidget {
  const CurrencyDetection({Key? key}) : super(key: key);

  @override
  State<CurrencyDetection> createState() => _CurrencyDetectionState();
}
class _CurrencyDetectionState extends State<CurrencyDetection> {
  late CameraController controller;
  late FlutterVision vision;
  late List<Map<String, dynamic>> yoloResults;
  CameraImage? cameraImage;
  bool isLoaded = false;
  bool isDetecting = false;
  String previousResult = '';
  double confidenceThreshold = 0.5;
  Duration repeatDuration =
  const Duration(seconds: 10); // Duration to repeat the result
  DateTime previousSpeechTime =
  DateTime.now().subtract(const Duration(seconds: 10));


  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    camerass = await availableCameras();
    vision = FlutterVision();
    controller = CameraController(camerass[0], ResolutionPreset.high);
    controller.initialize().then((value) {
      loadYoloModel().then((value) {
        setState(() {
          isLoaded = true;
          isDetecting = false;
          yoloResults = [];
        });
      });
    });
  }

  @override
  void dispose() async {
    super.dispose();
    await controller.dispose();
    await vision.closeYoloModel();
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (!isLoaded) {
      return const Scaffold(
        body: Center(
          child: Text("Model not loaded, waiting for it"),
        ),
      );
    }
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: CameraPreview(
              controller,
            ),
          ),
          ...displayBoxesAroundRecognizedObjects(size),
          Positioned(
            bottom: 75,
            width: MediaQuery.of(context).size.width,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 5, color: Colors.white, style: BorderStyle.solid),
              ),
              child: isDetecting
                  ? IconButton(
                onPressed: () async {
                  stopDetection();
                },
                icon: const Icon(
                  Icons.stop,
                  color: Colors.red,
                ),
                iconSize: 50,
              )
                  : IconButton(
                onPressed: () async {
                  await startDetection();
                },
                icon: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
                iconSize: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadYoloModel() async {
    await vision.loadYoloModel(
        labels: 'assets/models/curr.text',
        modelPath: 'assets/models/curr_float16.tflite',
        modelVersion: "yolov8",
        numThreads: 1,
        useGpu: false);
    setState(() {
      isLoaded = true;
    });
  }

  Future<void> yoloOnFrame(CameraImage cameraImage) async {
    final result = await vision.yoloOnFrame(
        bytesList: cameraImage.planes.map((plane) => plane.bytes).toList(),
        imageHeight: cameraImage.height,
        imageWidth: cameraImage.width,
        iouThreshold: 0.4,
        confThreshold: 0.4,
        classThreshold: 0.5);
    if (result.isNotEmpty) {
      setState(() {
        yoloResults = result;
        print('result = $result');
      });
    }
  }

  Future<void> startDetection() async {
    setState(() {
      isDetecting = true;
    });
    if (controller.value.isStreamingImages) {
      return;
    }
    await controller.startImageStream((image) async {
      if (isDetecting) {
        cameraImage = image;
        yoloOnFrame(image);
      }
    });
  }


  Future<void> stopDetection() async {
    setState(() {
      isDetecting = false;
      yoloResults.clear();
    });
  }


List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
  if (yoloResults.isEmpty) return [];
  double factorX = screen.width / (cameraImage?.height ?? 1);
  double factorY = screen.height / (cameraImage?.width ?? 1);

  Color colorPick = const Color.fromARGB(255, 50, 233, 30);

  return yoloResults.map((result) {
    double objectX = result["box"][0] * factorX;
    double objectY = result["box"][1] * factorY;
    double objectWidth = (result["box"][2] - result["box"][0]) * factorX;
    double objectHeight = (result["box"][3] - result["box"][1]) * factorY;
    speak() {
      String currentResult = result['tag'].toString();
      DateTime currentTime = DateTime.now();

      if (currentResult != previousResult ||
          currentTime.difference(previousSpeechTime) >= repeatDuration) {
        tts.flutterSpeak(currentResult);
        previousResult = currentResult;
        previousSpeechTime = currentTime;
      }
    }
    speak();

    return Positioned(
        left: objectX,
        top: objectY,
        width: objectWidth,
        height: objectHeight,
        child: Container(
        decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    border: Border.all(color: Colors.pink, width: 2.0),
    ),
          child: Text(
            "${result['tag']} ${(result['box'][4] * 100)}",
            style: TextStyle(
              background: Paint()..color = colorPick,
              color: const Color.fromARGB(255, 115, 0, 255),
              fontSize: 18.0,
            ),
          ),
        ),
    );
  }).toList();
}
}


class TTS {
  final FlutterTts flutterTts;

  TTS({
    String language = 'en_US',
    double volume = 1.0,
    double pitch = 1,
    double rate = 0.6,
  }) : flutterTts = FlutterTts() {
    flutterTts.setLanguage(language);
    flutterTts.setVolume(volume);
    flutterTts.setPitch(1);
    flutterTts.setSpeechRate(rate);
  }

  Future<void> flutterSpeak(String text) async {
    await flutterTts.speak(text);
  }
}


// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'dart:async';
// import 'package:flutter_vision/flutter_vision.dart';
// import 'package:flutter_tts/flutter_tts.dart';
//
//
// late List<CameraDescription> camerass;
// TTS tts = TTS();
//
// class YoloVideo2 extends StatefulWidget {
//   const YoloVideo2({Key? key}) : super(key: key);
//
//   @override
//   State<YoloVideo2> createState() => _YoloVideoState();
// }
//
// class _YoloVideoState extends State<YoloVideo2> {
//   late CameraController controller;
//   late FlutterVision vision;
//   late List<Map<String, dynamic>> yoloResults;
//
//   CameraImage? cameraImage;
//   bool isLoaded = false;
//   bool isDetecting = false;
//   String previousResult = '';
//   double confidenceThreshold = 0.5;
//   Duration repeatDuration =
//   const Duration(seconds: 10); // Duration to repeat the result
//   DateTime previousSpeechTime =
//   DateTime.now().subtract(const Duration(seconds: 10));
//
//   @override
//   void initState() {
//     super.initState();
//     init();
//   }
//
//   init() async {
//     camerass = await availableCameras();
//     vision = FlutterVision();
//     controller = CameraController(camerass[0], ResolutionPreset.high);
//     controller.initialize().then((value) {
//       loadYoloModel().then((value) {
//         setState(() {
//           isLoaded = true;
//           isDetecting = false;
//           yoloResults = [];
//         });
//       });
//     });
//   }
//
//   @override
//   void dispose() async {
//     super.dispose();
//     controller.dispose();
//     await vision.closeYoloModel();
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//
//
//     if (!isLoaded) {
//       return const Scaffold(
//         body: Center(
//           child: Text("Model not loaded, waiting for it"),
//         ),
//       );
//     }
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           AspectRatio(
//             aspectRatio: controller.value.aspectRatio,
//             child: CameraPreview(
//               controller,
//             ),
//           ),
//           ...displayBoxesAroundRecognizedObjects(size),
//           Positioned(
//             bottom: 75,
//             width: MediaQuery.of(context).size.width,
//             child: Container(
//               height: 80,
//               width: 80,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                     width: 5, color: Colors.white, style: BorderStyle.solid),
//               ),
//               child: isDetecting
//                   ? IconButton(
//                 onPressed: () async {
//                   stopDetection();
//                 },
//                 icon: const Icon(
//                   Icons.stop,
//                   color: Colors.red,
//                 ),
//                 iconSize: 50,
//               )
//                   : IconButton(
//                 onPressed: () async {
//                   await startDetection();
//                 },
//                 icon: const Icon(
//                   Icons.play_arrow,
//                   color: Colors.white,
//                 ),
//                 iconSize: 50,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> loadYoloModel() async {
//     await vision.loadYoloModel(
//         labels: 'assets/CLASSES.txt',
//         modelPath: 'assets/curr_float32.tflite',
//         modelVersion: "yolov8",
//         numThreads: 1,
//         useGpu: true);
//     setState(() {
//       isLoaded = true;
//     });
//   }
//
//   Future<void> yoloOnFrame(CameraImage cameraImage) async {
//     final result = await vision.yoloOnFrame(
//         bytesList: cameraImage.planes.map((plane) => plane.bytes).toList(),
//         imageHeight: cameraImage.height,
//         imageWidth: cameraImage.width,
//         iouThreshold: 0.4,
//         confThreshold: 0.4,
//         classThreshold: 0.5);
//     if (result.isNotEmpty) {
//       setState(() {
//         yoloResults = result;
//       });
// // String currentResult = result[0]['tag'].toString();
// //       DateTime currentTime = DateTime.now();
//
// //       if (currentResult != previousResult  ||
// //           currentTime.difference(previousSpeechTime) >= repeatDuration) {
//
// //        tts.flutterSpeak(currentResult);
// //         previousResult = currentResult;
// //         previousSpeechTime = currentTime;
//
// //       }
//     }
//   }
//
//   Future<void> startDetection() async {
//     setState(() {
//       isDetecting = true;
//     });
//     if (controller.value.isStreamingImages) {
//       return;
//     }
//     await controller.startImageStream((image) async {
//       if (isDetecting) {
//         cameraImage = image;
//         yoloOnFrame(image);
//       }
//     });
//   }
//
//
//
//
//   Future<void> stopDetection() async {
//     setState(() {
//       isDetecting = false;
//       yoloResults.clear();
//     });
//   }
//
//
//
//   List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
//     if (yoloResults.isEmpty) return [];
//     double factorX = screen.width / (cameraImage?.height ?? 1);
//     double factorY = screen.height / (cameraImage?.width ?? 1);
//
//     Color colorPick = const Color.fromARGB(255, 50, 233, 30);
//
//     return yoloResults.map((result) {
//       double objectX = result["box"][0] * factorX;
//       double objectY = result["box"][1] * factorY;
//       double objectWidth = (result["box"][2] - result["box"][0]) * factorX;
//       double objectHeight = (result["box"][3] - result["box"][1]) * factorY;
//
//       speak() {
//         String currentResult = result['tag'].toString();
//         DateTime currentTime = DateTime.now();
//
//         if (currentResult != previousResult ||
//             currentTime.difference(previousSpeechTime) >= repeatDuration) {
//           tts.flutterSpeak(currentResult);
//           previousResult = currentResult;
//           previousSpeechTime = currentTime;
//         }
//       }
//       speak();
//
//       return Positioned(
//         left: objectX,
//         top: objectY,
//         width: objectWidth,
//         height: objectHeight,
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: const BorderRadius.all(Radius.circular(10.0)),
//             border: Border.all(color: Colors.pink, width: 2.0),
//           ),
//           // ${(result['box'][4] * 100).toStringAsFixed(0)}% ${distance.toStringAsFixed(2)} away
//           child: Text(
//             "${result['tag']} ${(result['box'][4] * 100)}",
//             style: TextStyle(
//               background: Paint()..color = colorPick,
//               color: const Color.fromARGB(255, 115, 0, 255),
//               fontSize: 18.0,
//             ),
//           ),
//         ),
//       );
//     }).toList();
//   }
// }
//
//
//
// class TTS {
//   final FlutterTts flutterTts;
//
//   TTS({
//     String language = 'en_US',
//     double volume = 1.0,
//     double pitch = 1,
//     double rate = 0.6,
//   }) : flutterTts = FlutterTts() {
//     flutterTts.setLanguage(language);
//     flutterTts.setVolume(volume);
//     flutterTts.setPitch(1);
//     flutterTts.setSpeechRate(rate);
//   }
//
//   Future<void> flutterSpeak(String text) async {
//     await flutterTts.speak(text);
//   }
// }