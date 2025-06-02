import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/cubit/register/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  /* void userRegister(
      {required String name,
      required String email,
      required String phone,
      required String password}) {
    ResponseModel responseModel;
    // User user;

    emit(RegisterLoadState());
    DioHelper.postDate(
        url: 'login',
        data: {'email': email, 'password': password}).then((value) {
      responseModel = ResponseModel.fromJson(value.data);
      // user = User.fromJson(responseModel.data);

*/ /*      print(responseModel.message);
      print(responseModel.status);
      print('-------------------------------');
      print(user.name);
      print(user.token);*/ /*
      emit(RegisterSuccessState(responseModel));
    }).catchError((error) {
      //   print(error.toString());
      emit(RegisterErrorState(message: error.toString()));
    });
  }

  IconData suffixIcon = Icons.visibility_off;
  bool isPassword = true;*/

  void getVisibilityIcon() {
    emit(ChangeIconState());
  }

  IconData suffixIcon = Icons.visibility_off;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ChangeIconState());
  }
}
