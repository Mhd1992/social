import 'package:social_application/model/message_model.dart';
import 'package:social_application/model/post_like_model.dart';
import 'package:social_application/model/user_model.dart';

import '../../model/post_model.dart' show PostModel;

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

class SocialGetAllUserState extends SocialState {
  final List<UserModel?> userModel;

  SocialGetAllUserState({required this.userModel});
}

class ChangeBottomNaveState extends SocialState {}

class AddNewPostState extends SocialState {}

class AddProfileImageSuccessState extends SocialState {}

class AddProfileImageErrorState extends SocialState {}

class AddCoverImageSuccessState extends SocialState {}

class AddCoverImageErrorState extends SocialState {}

class CreatePostLoadState extends SocialState {}

class GetPostsSuccessState extends SocialState {
  final List<PostModel?> postModels;
  GetPostsSuccessState({required this.postModels});
}

class GetPostInitialState extends SocialState {}

class GetPostLoadingState extends SocialState {}

class GetPostsErrorState extends SocialState {
  final String error;

  GetPostsErrorState(this.error);
}

class GetLikedPostInitialState extends SocialState {}

class GetLikedPostLoadingState extends SocialState {}

class GetLikePostsErrorState extends SocialState {
  final String error;

  GetLikePostsErrorState(this.error);
}

class LikePostSuccessState extends SocialState {
  LikePostSuccessState();
}

//chat state
class GetAllChatMessageSuccessState extends SocialState {
  final List<MessageModel?> messageModel;
  GetAllChatMessageSuccessState({required this.messageModel});
}

class GetAllChatMessageErrorState extends SocialState {
  final String error;

  GetAllChatMessageErrorState(this.error);
}

class SendChatMessageSuccessState extends SocialState {}

class SendChatMessageErrorState extends SocialState {
  String error;
  SendChatMessageErrorState(this.error);
}
