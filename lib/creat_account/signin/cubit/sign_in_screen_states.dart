part of 'sign_in_screen_cubit.dart';

@immutable
abstract class SignInScreenStates {}

class SignInScreenInitialState extends SignInScreenStates {}

class SignInLoadingState extends  SignInScreenStates{}

class SignInSuccessState extends SignInScreenStates {}

class SignInFailureState extends SignInScreenStates {

  SignInFailureState(  {required String errorMessage});

}






