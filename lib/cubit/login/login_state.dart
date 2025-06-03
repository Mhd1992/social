import 'package:social_application/components/model/response_model.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String uId;
  LoginSuccessState(this.uId);
}

class ChangeIconState extends LoginState {}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState({required this.error});
}
