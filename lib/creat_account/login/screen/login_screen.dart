import 'package:custom_signin_buttons/custom_signin_buttons.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Home.dart';
import 'package:graduation_project/color_extension.dart';
import 'package:graduation_project/commen_widget/round_button.dart';
import 'package:graduation_project/commen_widget/round_textfield.dart';

import '../../register/screen/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscure =  true ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome Back",
                style: TextStyle(
                    color: TColor.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 60),
              TextFieldComponent(
                controller: emailController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                labelText: "Email",
                prefixIcon: Icon(Icons.email_outlined),
              ),
              SizedBox(
                height: 15,
              ),
              TextFieldComponent(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                obscureText: obscure,
                labelText: "Password",
                controller: passwordController,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscure =! obscure ;
                      });
                    },
                    icon: obscure == true ?
                    Icon(Icons.visibility_outlined):
                    Icon(Icons.visibility_off_outlined)
                ),
                prefixIcon: Icon(Icons.lock_outline),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forget Your Password?",
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.black54),
                    )),
              ),
              SizedBox(
                height: 70,
              ),
              RoundButton(
                  title: "Login",
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                    //const CompleteProfileView()));
                  }),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Expanded(
                      child:Divider(
                        color: Colors.black,
                      ) ),
                  const SizedBox(width: 20,),
                  Text("Or with"),
                  const SizedBox(width: 20,),
                  Expanded(
                      child:Divider(
                        color: Colors.black,
                      ) ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Card(
                        elevation: 20,
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                              child: Icon(
                            Icons.apple_outlined,
                            size: 40,
                          )),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Card(
                        elevation: 20,
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                              child: Icon(FontAwesomeIcons.google)
                          )),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account ? "),
                  TextButton(
                    onPressed: () {
                      navigateToRegisterScreen();
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void navigateToRegisterScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegisterScreen()));
  }
}
