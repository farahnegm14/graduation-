import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:graduation_project/commen_component/app_buttons/round_button.dart';
import 'package:graduation_project/home_screen/Home.dart';
import 'package:graduation_project/creat_account/login/screen/login_screen.dart';
import 'package:graduation_project/creat_account/register/screen/register_screen.dart';

FlutterTts flutterTts = FlutterTts();

class StartUpScreen extends StatefulWidget {
  const StartUpScreen({Key? key}) : super(key: key);

  @override
  State<StartUpScreen> createState() => _StartUpScreenState();
}

class _StartUpScreenState extends State<StartUpScreen> {
  @override
  void initState() {
    flutterTts.setSpeechRate(0.60);
    flutterTts.setLanguage("en-US");
    flutterTts.speak("Swipe right to skip");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Image.asset(
                    "assets/logo/logo.png",
                    height: 350,
                    width: 350,
                  ),
                  RoundButton(
                      title: "Login",
                      onPressed: (){
                        navigateToLoginScreen();
                      }),
                  const SizedBox(height: 20,),
                  RoundButton(
                      title:"Register",
                      onPressed: (){
                        navigateToRegisterScreen();
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToLoginScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LoginScreen();
    }));
  }

  void navigateToRegisterScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return RegisterScreen();
    }));
  }

  void navigateToHomeScreen() {
    Navigator.push(context,MaterialPageRoute(builder: (context){
      return HomeScreen();
    }));
  }
}
