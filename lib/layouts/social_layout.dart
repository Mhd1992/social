import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/components/icon_broken.dart';
import 'package:social_application/components/widget_main.dart';
import 'package:social_application/cubit/social/social_cubit.dart';
import 'package:social_application/local/cache_helper.dart';
import 'package:social_application/model/user_model.dart';
import 'package:social_application/screens/new_post/new_post_screen.dart';

import '../cubit/social/social_state.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = SocialCubit.get(context);

    return BlocConsumer<SocialCubit, SocialState>(listener: (context, state) {
      if (state is AddNewPostState) {
        navigateTo(context, NewPostScreen());
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(cubit.titles[cubit.currentIndex]),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(IconBroken.Notification)),
            IconButton(onPressed: () {}, icon: const Icon(IconBroken.Search))
          ],
        ),
        body: cubit.screens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.currentIndex,
          onTap: (index) {
            cubit.selectBottomNav(index);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(IconBroken.Home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Chat,
                ),
                label: 'Chat'),
            BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Paper_Negative,
                ),
                label: 'AddPost'),
            BottomNavigationBarItem(
                icon: Icon(IconBroken.Location), label: 'Location'),
            BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting), label: 'Settings'),
          ],
        ),
      );
    });
  }
}

/*
*
* ConditionalBuilder(
                condition: cubit.userModel != null,
                builder: (context) => Column(
                  children: [
                    cubit.userModel!.isEmailVerified == true
                        ? Container()
                        : Container(
                            color: const Color.fromARGB(153, 255, 193, 7),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  const Expanded(
                                      child: Text('Please verify your email')),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  defaultTextButton(
                                      function: () {
                                        FirebaseAuth.instance.currentUser!
                                            .sendEmailVerification()
                                            .then((value) {
                                          cubit.updateVerifyState(uId, true);
                                          // FirebaseAuth.instance.currentUser.u
                                          showToastMessage(
                                              message: 'Check you mail',
                                              state: ToastState.success);
                                        }).catchError((error) {});
                                      },
                                      text: 'send')
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ))
*
* */
