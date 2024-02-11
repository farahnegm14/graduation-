import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/commen_component/app_buttons/round_button.dart';
import 'package:graduation_project/commen_component/app_widgets/round_textfield.dart';
import 'package:graduation_project/creat_account/signin/screen/sign_in_screen.dart';
import 'package:graduation_project/creat_account/signup/cubit/sign_up_screen_cubit.dart';
import 'package:graduation_project/creat_account/signup/cubit/sign_up_screen_states.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController =TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController =TextEditingController();
  final cubit  = SignUpScreenCubit();
  final GlobalKey<FormState> _formKey =GlobalKey<FormState>();
  bool obscure =  true ;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    lastNameController.dispose();
    firstNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: Container(
                width: double.infinity,
                height: 620,
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
                    child: SingleChildScrollView(
                      child: BlocConsumer<SignUpScreenCubit,SignUpScreenStates>(
                        listener: (context, state) {
                        if(state is SignUpSuccessState){
                          Navigator.pushReplacement(
                              context,MaterialPageRoute(
                              builder: (context)=>const SignInScreen()));
                        }
                      },
                        builder: (context,state){
                          return Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const  Text("SIGN UP",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                const SizedBox(height: 30,),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFieldComponent(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your First Name';
                                          }
                                          // You can add more advanced email validation if needed
                                          return null;
                                        },
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.name,
                                        hintText: "First Name",
                                        prefixIcon: const Icon(Icons.person),
                                        controller: firstNameController,
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    Expanded(
                                      child: TextFieldComponent(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your Last Name ';
                                          }
                                          // You can add more advanced email validation if needed
                                          return null;
                                        },
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.name,
                                        hintText: "Last Name",
                                        controller: lastNameController,
                                        prefixIcon: const Icon(Icons.person),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 25,),
                                TextFieldComponent(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your Phone Number';
                                    }
                                    // You can add more advanced email validation if needed
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.name,
                                  hintText: "phone Number",
                                  prefixIcon: const Icon(Icons.phone),
                                  controller: phoneNumberController,
                                ),
                                const SizedBox(height: 20,),
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
                                    } if (value.length < 8) {
                                      return 'Password must be at least 8 characters long';
                                    }

                                    // You can add more advanced password validation if needed
                                    return null;
                                  },
                                  obscureText: obscure,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.visiblePassword,
                                  hintText: "password",
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: IconButton(onPressed: (){
                                    setState(() {
                                      obscure =! obscure ;
                                    });
                                  },
                                      icon: obscure ? const Icon(Icons.visibility):
                                      const Icon(Icons.visibility_off)
                                  ),
                                  controller: passwordController,
                                ),
                                const SizedBox(height: 30,),
                                ConditionalBuilder(
                                    condition: state is! SignUpLoadingState,
                                    builder: (BuildContext context) {
                                      return Center(
                                        child: RoundButton(
                                          title: "SIGN UP",
                                          onPressed: (){
                                            if (_formKey.currentState?.validate() ?? false) {
                                              signUp();
                                            }
                                          },
                                        ),
                                      );
                                    },
                                    fallback: (BuildContext context) => const Center(child: CircularProgressIndicator(),)),

                                const SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "already have a account ?",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15
                                      ),
                                    ),
                                    TextButton(onPressed: (){
                                      navigateToSignInScreen();
                                    },
                                        child: const  Text(
                                          "SIGN IN ",
                                          style: TextStyle(
                                            color: Colors.blue,

                                          ),
                                        ))
                                  ],
                                )




                              ],
                            ),
                          );
                        },
                      ),
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

  void navigateToSignInScreen() {
Navigator.push(context, MaterialPageRoute(builder: (context){
  return const SignInScreen();
}));
  }

  void signUp() {
    String email = emailController.text;
    String password =  passwordController.text;
    String firstName =  firstNameController.text ;
    String lastName =  lastNameController.text ;
    String phoneNumber = phoneNumberController.text ;

    cubit.signUp(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,

    );
  }
}

