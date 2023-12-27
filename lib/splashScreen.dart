import 'package:flutter/material.dart';
import 'package:graduation_project/OnBoarding/onBoarding_View.dart';

class SplashScreen  extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    Future.delayed( Duration(seconds: 2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> OnBoardingView()));
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.white,
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 300),
            Image.asset( 'assets/logo/splash icon.png',width: size.width-200,),
            const SizedBox(height: 35),
            const Text( 'BASEERA',style: TextStyle(fontSize: 30, color: Colors.black38),)
          ],
        ),
      ),
    );
  }
}
//
// import 'dart:async';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter/material.dart';
// import 'package:graduation_project/OnBoarding/onBoarding_View.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     Timer(const Duration(seconds: 2), () {
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
//         return const OnBoardingView();
//       }));
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned(
//           top: -89,
//           left: 79,
//           child: Container(
//             width: 380.w,
//             height: 380.h,
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//               color: Color(0XFF86BEFF),
//             ),
//           ),
//         ),
//         Positioned(
//           top: -60,
//           left: -100,
//           child: Container(
//             width: 250.w,
//             height: 250.h,
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//               color: Color(0XFF489CFF),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
