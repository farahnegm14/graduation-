import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:graduation_project/data_source/local/preference_utils.dart';
import 'package:meta/meta.dart';
part 'sign_in_screen_states.dart';

class SignInScreenCubit extends Cubit<SignInScreenStates> {
  SignInScreenCubit() : super(SignInScreenInitialState());
  Dio dio = Dio();
  void signIn({
    required String email,
    required String password,
  }) {
    emit(SignInLoadingState());
    dio.post(
      "https://basyrah.vercel.app/auth/login",
      data: {
        "email": email,
        "password":password,

      },
    ).then((value) {
      if (value.statusCode == 200) {
         _saveUserData(value.data);
        emit(SignInSuccessState());
        print('login Success');
      } else {
        SignInFailureState(errorMessage: value.statusMessage.toString());
      }
    }).catchError((error) {
      emit(SignInFailureState(errorMessage: error.toString()));
      print(error.toString());
    });
  }

  void _saveUserData(data) {
    PreferenceUtils.setString("apiToken", data['token']);
  }
}
