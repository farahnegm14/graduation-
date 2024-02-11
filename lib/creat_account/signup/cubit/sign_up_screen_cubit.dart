import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/creat_account/signup/cubit/sign_up_screen_states.dart';


class SignUpScreenCubit extends Cubit<SignUpScreenStates> {
  SignUpScreenCubit() : super(SignUpInitialState());
  final dio = Dio();
  void signUp({
    required email ,
    required password,
    required firstName,
    required lastName,
    required phoneNumber
  }) async {
    emit(SignUpLoadingState());
    await dio.post(
        'https://basyrah.vercel.app/auth/register',
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "phone": phoneNumber,
          "email": email,
          "password": password
        }).then((value) {
      emit(SignUpSuccessState());
      print('Register success ya farah ');
    }).catchError((error){
      emit(SignUpFailureState(error.toString()));
    });

  }

}

