import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_application/components/model/response_model.dart';
import 'package:social_application/cubit/register/register_state.dart';
import 'package:social_application/model/user_model.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
      {required String name,
      required String email,
      required String phone,
      required String password}) {
    emit(RegisterLoadState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(name: name, email: email, phone: phone, uId: value.user!.uid);
    }).catchError((error) {
      emit(RegisterErrorState(message: error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    UserModel userModel = UserModel(
        name,
        phone,
        email,
        uId,
        'https://www.freepik.com/free-vector/blue-circle-with-white-user_145857007.htm#fromView=keyword&page=1&position=0&uuid=a069a414-4290-43af-9044-94d2f8656844&query=Default+User',
        false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((val) {
      emit(CreateUserSuccess());
    }).catchError((error) {
      emit(CreateUserErrorSuccess(error: error.toString()));
    });
  }

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
