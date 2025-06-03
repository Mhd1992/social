import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/cubit/social/social_state.dart';
import 'package:social_application/local/cache_helper.dart';
import 'package:social_application/model/user_model.dart';
import 'package:social_application/screens/chats/chat_screens.dart';
import 'package:social_application/screens/feeds/feed_screens.dart';
import 'package:social_application/screens/settings/settings_screens.dart';
import 'package:social_application/screens/users/user_screens.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserDate() {
    emit(SocialLoadingUserState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((val) {
      print(val.data()!.keys.contains('isEmailVerifiedId'));
      userModel = UserModel.fromJson(val.data());
      print(
          '----------->>>>${userModel!.name} --- ${userModel!.isEmailVerified}');
      emit(SocialGetUserState(userModel: userModel));
    }).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  void updateVerifyState(String? userId, bool isVerified) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'isEmailVerifiedId': isVerified}).then((_) {
      print("Verified email updated successfully!");
    }).catchError((error) {
      print("Failed to update verified email: $error");
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    const FeedScreens(),
    const ChatScreens(),
    const UserScreens(),
    const SettingsScreens(),
  ];

  List<String> titles = ['New Feeds', 'Chat', 'Users', 'Settings'];

  void selectBottomNav(int index) {
    currentIndex = index;
    emit(ChangeBottomNaveState());
  }
}
