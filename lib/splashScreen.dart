import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:graduation_project/OnBoarding/onBoarding_View.dart';

FlutterTts flutterTts = FlutterTts();


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    flutterTts.setSpeechRate(0.60);
    flutterTts.setLanguage("ar-SA");
    flutterTts.speak("بصيرة");
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const PageViewScreen();
      }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            top: -89,
            left: 79,
            child: Container(
              width: 380.w,
              height: 380.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0XFF86BEFF),
              ),
            ),
          ),
          Positioned(
            top: -60,
            left: -100,
            child: Container(
              width: 250.w,
              height: 250.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0XFF489CFF),
              ),
            ),
          ),
          Positioned(
            top: 235,
            left: 10,
            right: 5,
            child: Container(
              width:400,
              height: 400,
              child: Image.asset("assets/logo/logo.png",),
            )

          ),
        ],
      ),
    );
  }
}
