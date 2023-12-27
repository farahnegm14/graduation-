import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:graduation_project/main.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);


  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  bool isWorking = false;
  String result = '';
  CameraController? cameraController;
  CameraImage? imageCamera;


   Future<dynamic>loadModel() async {
    try {
      await Tflite.loadModel(
          model: 'assets/mobilenet_v1_1.0_224.tflite',
          labels: 'assets/mobilenet_v1_1.0_224.txt'
      );
      // Use the interpreter for inference
    } catch (error) {
      print('Error loading model==============: $error');
    }
  }

   initCamera() {
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    cameraController?.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController?.startImageStream((imageFromStream) => {
              if (!isWorking)
                {
                  isWorking = true,
                  imageCamera = imageFromStream,
                  runModelOnFrame(),
                }
            });
      });
    });
  }
  runModelOnFrame() async {
    if (imageCamera != null) {
      var recognitions = await Tflite.runModelOnFrame(
        bytesList: imageCamera!.planes.map((plane) => plane.bytes).toList(),
        imageHeight: imageCamera!.height,
        imageWidth: imageCamera!.width,
        imageMean: 127.5, // Corrected to 'imageMean'
        imageStd: 127.5,
        rotation: 90,
        numResults: 3,
        threshold: 0.1,
        asynch: true,
      );

      result = '';
      recognitions?.forEach((response) {
        result += response['label'] + ' ' + (response['confidence'] as double).toStringAsFixed(2) + '\n\n';
      });

      // Update the UI with the results
      setState(() {});

      isWorking = false;
    }
  }

  @override
  initState()  {
    super.initState();
    loadModel();

  }

  @override
  void dispose() async {
    super.dispose();
    Tflite.close();
    cameraController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  initCamera();
                },
                icon: Icon(Icons.camera_alt)),
          ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              imageCamera == null
                  ? Center(
                    child: Container(
                        child: const  Icon(
                          Icons.photo_camera_front,
                          size: 100,
                        ),
                      ),
                  )
                  : Container(
                      height:double.infinity ,
                      child: AspectRatio(
                        aspectRatio: cameraController!.value.aspectRatio,
                        child: CameraPreview(cameraController!),
                      ),
                    ),
              Container(
                margin: EdgeInsets.only(top: 55),
                child: SingleChildScrollView(
                  child: Text(result,style: TextStyle(backgroundColor: Colors.white),
                  textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


