import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/splashScreen.dart';


 List<CameraDescription> cameras=[];
 Future<void> main() async{
   WidgetsFlutterBinding.ensureInitialized();
   cameras = await availableCameras();
   runApp(const MyApp());
}
// void main(){
//   runApp( const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
