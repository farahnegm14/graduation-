import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:graduation_project/camera_model_screens/currency_detection/screen/currency_detection.dart';
import 'package:graduation_project/camera_model_screens/object_detection/screen/object_detection.dart';
import 'package:graduation_project/notifications_screen.dart';
import '../commen_component/app_buttons/object_detection_button.dart';
import '../commen_component/app_colors/color_extension.dart';
FlutterTts flutterTts = FlutterTts();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    flutterTts.setSpeechRate(0.55);
    flutterTts.setLanguage("en-US");
    flutterTts.speak("Tap to detect object or Double Tap to identify currency");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: GradientAppBar(
          title: Text(' BASYRAH'),
          gradient: LinearGradient(
            colors: [TColor.primaryColor1,TColor.primaryColor2],
          ),
          centerTitle: true,
          actions:[
            IconButton(onPressed: (){
              navigateToNotificationScreen();
            }, icon: const Icon( Icons.notifications,color: Colors.white)),
          ],
          leading:  IconButton(onPressed: (){},
              icon:const Icon(Icons.person,color: Colors.white)),
        ),
         body:
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              CustomButtonDetection(
                  icon:Icons.data_object_outlined,
                  text: "TAP HERE TO DETECT OBJECT.",
                  onTap: (){
                    navigateToObjectDetection();
                  }),
              const SizedBox(height: 20,),
              CustomButtonDetection(
                  icon:Icons.monetization_on_outlined,
                  text: "TAP HERE TO IDENTIFY CURRENCY.",
                  onTap: (){
                    navigateToCurrencyDetection();
                  }),
            ],
          ),
       ),

      ),
    );
  }

  void navigateToNotificationScreen() {
     Navigator.push(context,
         MaterialPageRoute(builder: (context)=>const NotificationScreen()));
  }

  void navigateToObjectDetection() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ObjectDetection()));
  }

  void navigateToCurrencyDetection() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const CurrencyDetection()));
  }
}


