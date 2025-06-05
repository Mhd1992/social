import 'package:social_application/model/user_model.dart';

abstract class SocialState {}

class SocialInitialState extends SocialState {}

class SocialGetUserState extends SocialState {
  final UserModel? userModel;

  SocialGetUserState({required this.userModel});
}

class SocialLoadingUserState extends SocialState {}

class SocialGetUserErrorState extends SocialState {
  final String error;

  SocialGetUserErrorState(this.error);
}

class ChangeBottomNaveState extends SocialState {}

class AddNewPostState extends SocialState {}
