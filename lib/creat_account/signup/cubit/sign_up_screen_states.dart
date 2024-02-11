abstract class SignUpScreenStates {}

class SignUpInitialState extends SignUpScreenStates {}

class SignUpSuccessState extends SignUpScreenStates {}

class SignUpLoadingState extends SignUpScreenStates {}

class SignUpFailureState extends SignUpScreenStates {
  final String errorMessage ;
  SignUpFailureState(this.errorMessage);


}