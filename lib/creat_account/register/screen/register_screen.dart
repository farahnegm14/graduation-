import 'package:custom_signin_buttons/custom_signin_buttons.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/commen_component/app_buttons/round_button.dart';
import 'package:graduation_project/commen_component/app_colors/color_extension.dart';
import 'package:graduation_project/commen_component/app_widgets/round_textfield.dart';
import 'package:graduation_project/home_screen/Home.dart';
import '../../login/screen/login_screen.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController =TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool obscure = true ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Register",
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 50),
                TextFieldComponent(
                  controller: userNameController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  labelText: "User Name",
                  prefixIcon: Icon(Icons.person),
                ),
                const SizedBox(height: 15,),
                TextFieldComponent(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  labelText: "Email",
                  controller: emailController,
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                const SizedBox(height: 15,),
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
                      icon: obscure ?
                      Icon(Icons.visibility_outlined):
                      Icon(Icons.visibility_off_outlined)
                  ),
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                const SizedBox(height: 15,),
                TextFieldComponent(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: obscure,
                  labelText: "Confirm Password",
                  controller: confirmPasswordController,
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                SizedBox(
                  height: 50,
                ),
                RoundButton(
                    title: "Register",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomeScreen()));
                      //const CompleteProfileView()));
                    }),
               const  SizedBox(
                  height: 20,
                ),
               const  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Expanded(
                        child:Divider(
                          color: Colors.black,
                        ) ),
                    SizedBox(width: 20,),
                    Text("Or with"),
                     SizedBox(width: 20,),
                    Expanded(
                        child:Divider(
                          color: Colors.black,
                        ) ),
                  ],
                ),
                const SizedBox(height: 20,),
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
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(" Have Already Account ?"),
                    TextButton(
                      onPressed: () {
                        navigateToLoginScreen();
                        },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void navigateToLoginScreen() {
    Navigator.push(context,MaterialPageRoute(builder: (context)=>const LoginScreen()));
  }
}

