import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/user_profile/cubit/user_profile_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(InitialUserState());

  Future<void> getUserData(String userToken) async {
    try {
      emit(LoadingUserState());

      // Make API request using Dio
      final response = await Dio().get(
        'https://basyrah.vercel.app/auth/profile',
        options: Options(headers: {'token': '$userToken'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        // Extract user data from the response
        final firstName = data['result']['firstName'];
        final lastName = data['result']['lastName'];
        final email = data['result']['email'];
        final phoneNumber = data['result']['phone'];
        print(data);
        emit(LoadedUserState(
          firstName: firstName,
          lastName: lastName,
          email: email,
          phoneNumber: phoneNumber,
        ));
      } else {
        emit(ErrorUserState('Failed to fetch user data'));
      }
    } catch (e) {
      emit(ErrorUserState('Error: $e'));
    }
  }

  Future<void> logOut(String userToken) async {
    try {
      emit(LogOutLoading());

      // Make API request to logout using Dio with headers
      final response = await Dio().get(
        'https://basyrah.vercel.app/auth/logout',
        options: Options(headers: {'token': '$userToken'}),
      );

      if (response.statusCode == 200) {
        emit(LogOutSuccsses());
      } else {
        emit(LogOutFailer('Failed to logout'));
      }
    } catch (e) {
      emit(LogOutFailer('Error: $e'));
    }
  }

  Future<void> deleteAccount(String userToken) async {
    try {
      emit(DeleteAccountLoading());
      // Make API request to logout using Dio with headers
      final response = await Dio().get(
        'https://basyrah.vercel.app/auth/account/delete',
        options: Options(headers: {'token': '$userToken'}),
      );

      if (response.statusCode == 200) {
        emit(DeleteAccountSuccsses());
      } else {
        emit(DeleteAccountFailer('Failed to logout'));
      }
    } catch (e) {
      emit(DeleteAccountFailer('Error: $e'));
    }

  }
}
