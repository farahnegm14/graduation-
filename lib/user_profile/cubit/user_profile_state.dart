// states.dart

abstract class UserState {}

class InitialUserState extends UserState {}

class LoadingUserState extends UserState {}

class LoadedUserState extends UserState {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  LoadedUserState({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  });
}

class ErrorUserState extends UserState {
  final String error;

  ErrorUserState(this.error);
}
class LogOutLoading extends UserState {}
class LogOutSuccsses extends UserState{}
class LogOutFailer extends UserState {
  final String error;
  LogOutFailer(this.error);
}

class DeleteAccountLoading extends UserState {}
class DeleteAccountSuccsses extends UserState{}
class DeleteAccountFailer extends UserState {
  final String error;
  DeleteAccountFailer(this.error);
}