import 'package:flutter/material.dart';
import 'package:graduation_project/Home.dart';
import 'package:graduation_project/commen_widget/round_button.dart';
import 'package:graduation_project/creat_account/login/screen/login_screen.dart';
import 'package:graduation_project/creat_account/register/screen/register_screen.dart';

class StartUpScreen extends StatefulWidget {
  const StartUpScreen({Key? key}) : super(key: key);

  @override
  State<StartUpScreen> createState() => _StartUpScreenState();
}

class _StartUpScreenState extends State<StartUpScreen> {
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
                    "assets/logo/splash icon.png",
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 30,),
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
            const Spacer(),
            RoundButton(
              bottomCircular: 0,
              title:  'Tap twice to Skip',
              onTap: (){
                navigateToHomeScreen();
              },

            )
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
      return Home();
    }));
  }
}
