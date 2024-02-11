import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/commen_component/app_buttons/round_button.dart';
import 'package:graduation_project/commen_component/app_colors/color_extension.dart';
import 'package:graduation_project/commen_component/design_ovarall/user_profile_component.dart';
import 'package:graduation_project/commen_component/design_ovarall/wave_design.dart';
import 'package:graduation_project/creat_account/signin/screen/sign_in_screen.dart';
import 'package:graduation_project/creat_account/signup/screen/sign_up_screen.dart';
import 'package:graduation_project/data_source/local/preference_utils.dart';
import 'package:graduation_project/home_screen/Home.dart';
import 'package:graduation_project/user_profile/cubit/user_profile_cubit.dart';
import 'package:graduation_project/user_profile/cubit/user_profile_state.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String userToken = PreferenceUtils.getString("apiToken").toString() ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit.getUserData(userToken);
  }
  final cubit  = UserCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        body:PreferenceUtils.getString("apiToken").isEmpty?
        SafeArea(
          child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                child: Card(
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:Column(
                      children: [
                        Image.asset("assets/image/Empty box.png",
                          height: 250,),
                        const  Text("You Should Have Account First",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                        ),
                        const  SizedBox(height: 30,),
                        RoundButton(
                            buttomSize: 200,
                            title:"SignUp",
                            onPressed: (){
                              navigateToSignUpScreen();
                            }),
                      ],

                    ),
                  ),
                ),
              )
          ),
        ):
        Container(
          width: double.infinity,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(bottom: 35,),
              child: BlocBuilder<UserCubit,UserState>(
                builder: (context, state) {
                  if (state is LoadingUserState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is LoadedUserState) {
                    return buildUserDataWidget(state);
                  } else if (state is ErrorUserState) {
                    return Center(child: Text('Error: ${state.error}'));
                  } else {
                    return Center(child: Text('Initial State'));
                  }
                },

              ),
            ),
          ),
        )
      ),
    );
  }

  void navigateToSignUpScreen() {
    Navigator.push(context,MaterialPageRoute(builder: (context){
      return const SignUpScreen();
    }));
  }

  Widget buildUserDataWidget(LoadedUserState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Opacity(
              opacity: 1,
              child: ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  color: TColor.primaryColor2,
                  height: 200,

                ),
              ),
            ),
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                color: TColor.primaryColor1,
                height: 185,

              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 60),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child:CircleAvatar(
                      backgroundColor: TColor.primaryColor2,
                      radius: 80,
                    ),
                  ),
                  Center(
                    child: InkWell(
                      onTap: (){},
                      child: const CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage("assets/image/user_pic.jpg")),
                    ),
                  ),


                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20,),
        Text(
          "${state.firstName} ${state.lastName}",
          style: TextStyle(
              color: TColor.secondaryColor1,
              fontSize: 30,
              fontWeight: FontWeight.bold
          ),
        ),
        Text("${state.email}",
          style: TextStyle(
            color: TColor.secondaryColor1,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 40,),
        UserDataComponent(
            labelText: "First Name",
            userData: "${state.firstName}",
            icon: Icons.person),
        const SizedBox(height: 20,),
        UserDataComponent(
            labelText: "Last Name",
            userData: "${state.lastName}",
            icon: Icons.person),
        const SizedBox(height: 20,),
        UserDataComponent(
            labelText: "Phone Number",
            userData: "${state.phoneNumber}",
            icon: Icons.phone),
        const SizedBox(height: 60,),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: [
              Expanded(
                child:  ConditionalBuilder(
                    condition: state is! LogOutLoading,
                    builder: (BuildContext context) {
                      return Center(
                        child:  RoundButton(
                            onPressed: (){
                              logout();
                            },
                            title: "Log out"),
                      );
                    },
                    fallback: (BuildContext context) => const Center(child: CircularProgressIndicator(),)),
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: ConditionalBuilder(
                    condition: state is! DeleteAccountLoading,
                    builder: (BuildContext context) {
                      return Center(
                        child:  RoundButton(title: "Delete Account",
                          onPressed: (){deleteAccount();
                          },)
                      );
                    },
                    fallback: (BuildContext context) => const Center(child: CircularProgressIndicator(),)),

              ),
            ],
          ),
        )



      ],
    );
  }

  void logout() {
    cubit.logOut(userToken);
    PreferenceUtils.clear();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return const SignInScreen();
    }));

  }

  void deleteAccount() {
    cubit.deleteAccount(userToken);
    PreferenceUtils.clear();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return const HomeScreen();
    }));
  }
}
