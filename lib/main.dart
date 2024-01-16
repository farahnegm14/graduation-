import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:graduation_project/home_screen/Home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/splashScreen.dart';


 List<CameraDescription> cameras=[];
 Future<void> main() async{
   WidgetsFlutterBinding.ensureInitialized();
   // cameras = await availableCameras();
   runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}
