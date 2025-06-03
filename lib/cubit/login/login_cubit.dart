import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/components/model/response_model.dart';
import 'package:social_application/cubit/login/login_state.dart';
import 'package:social_application/network/dio_helper.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required String email, required String password}) {
    ResponseModel responseModel = ResponseModel(); // User user;

    emit(LoginLoadState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print('SUCCESS LOGIN');
      print(value.user);
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error: error.toString()));
    });
  }

  IconData suffixIcon = Icons.visibility_off;
  bool isPassword = true;

  void getVisibilityIcon() {
    emit(ChangeIconState());
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ChangeIconState());
  }
}
