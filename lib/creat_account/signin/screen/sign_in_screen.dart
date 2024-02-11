import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/commen_component/app_buttons/round_button.dart';
import 'package:graduation_project/commen_component/app_widgets/round_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/creat_account/signin/cubit/sign_in_screen_cubit.dart';
import 'package:graduation_project/home_screen/Home.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  final emailController =TextEditingController();
  final passwordController = TextEditingController();
  final cubit =  SignInScreenCubit();
  final GlobalKey<FormState> _formKey =GlobalKey<FormState>();
  bool obscure = true ;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit ,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: Container(
                width: double.infinity,
                height: 500,
                decoration: const BoxDecoration(
                    color: Colors.white
                ),
                child: Card(
                  color: Colors.white,
                  elevation: 20,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20,left: 10, right: 10),
                    child: BlocConsumer<SignInScreenCubit, SignInScreenStates>(
                      listener: (context, state) {
                        if(state is SignInSuccessState){
                          Navigator.pushReplacement(
                              context,MaterialPageRoute(
                              builder: (context)=>const HomeScreen()));
                        }
                      },
                      builder: (context, state){
                      return Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const  Text("SIGN IN",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(height: 30,),
                            TextFieldComponent(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                // You can add more advanced email validation if needed
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              hintText: "Email",
                              prefixIcon: const Icon(Icons.email),
                              controller: emailController,
                            ),
                            const SizedBox(height: 20,),
                            TextFieldComponent(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                } if (value.length < 6) {
                                  return 'Password must be at least 6 characters long';
                                }

                                // You can add more advanced password validation if needed
                                return null;
                              },
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: obscure,
                              hintText: "Password",
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(onPressed: (){
                                setState(() {
                                  obscure =! obscure ;
                                });
                              },
                                  icon: obscure? const Icon(Icons.visibility):
                                       const Icon(Icons.visibility_off)
                              ),
                              controller: passwordController,
                            ),
                            const SizedBox(height: 25,),
                            ConditionalBuilder(
                                condition: state is! SignInLoadingState,
                                builder: (BuildContext context) {
                                  return Center(
                                    child:  RoundButton(
                                      title: "SIGN IN",
                                      onPressed: (){
                                        if (_formKey.currentState?.validate() ?? false) {
                                          signIn();
                                        }
                                      },
                                    ),
                                  );
                                },
                                fallback: (BuildContext context) => const Center(child: CircularProgressIndicator(),)),

                            const SizedBox(height: 20,),
                            Center(
                              child: TextButton(onPressed: (){},
                                  child: const Text("forget your password !")),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "don\'t have a account ?",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15
                                  ),
                                ),
                                TextButton(onPressed: (){
                                  navigateToSignUPScreen();
                                },
                                    child: const  Text(
                                      "SIGN UP",
                                      style: TextStyle(
                                        color: Colors.blue,

                                      ),
                                    ))
                              ],
                            )




                          ],
                        ),
                      );
                      }
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void navigateToSignUPScreen() {
    Navigator.pop(context);
  }

  void signIn() {
    String email = emailController.text ;
    String password = passwordController.text ;
    cubit.signIn(
        email: email,
        password: password) ;
  }

}

