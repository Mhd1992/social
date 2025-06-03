import 'package:social_application/components/model/response_model.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final ResponseModel? responseModel;

  RegisterSuccessState(this.responseModel);
}

class RegisterErrorState extends RegisterState {
  final String? message;

  RegisterErrorState({this.message});
}

class ChangeIconState extends RegisterState {}

class CreateUserSuccess extends RegisterState {}

class CreateUserErrorSuccess extends RegisterState {
  final String error;
  CreateUserErrorSuccess({required this.error});
}
