import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_application/components/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/components/widget_main.dart';
import 'package:social_application/cubit/social/social_cubit.dart';
import 'package:social_application/cubit/social/social_state.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        // var userModel = SocialCubit.get(context).userModel;
        final cubit = SocialCubit.get(context);
        final profileImage = cubit.profileImage;
        final coverImage = cubit.coverImage;

        nameController.text = cubit.userModel!.name.toString();
        bioController.text = cubit.userModel!.bio!;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(IconBroken.Arrow___Left_2)),
            title: Text('EditProfileScreen'),
            centerTitle: true,
            actions: [
              defaultTextButton(
                  function: () {
                    cubit.updateUserData(
                        uId: cubit.userModel!.uId,
                        name: nameController.text,
                        bio: bioController.text,
                        phone: cubit.userModel!.phone,
                        email: cubit.userModel!.email);
                  },
                  text: 'Update'),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          body: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: (cubit.userModel!.coverImage!.isEmpty)
                              ? AssetImage(
                                  'assets/images/image3.png',
                                )
                              : NetworkImage('${cubit.userModel?.coverImage}'),
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(130, 30),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            child: CircleAvatar(
                              radius: 41,
                              child: (profileImage) == null
                                  ? CircleAvatar(
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      radius: 48,
                                      backgroundImage: NetworkImage(
                                          '${cubit.userModel?.image}'),
                                    )
                                  : Image.file(profileImage),
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                          ),
                          InkWell(
                            onTap: () {
                              //  cubit.getIProfileImage();
                              cubit.uploadCloudinaryImage();
                            },
                            child: CircleAvatar(
                                radius: 20, child: Icon(IconBroken.Camera)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(-150, -100),
                    child: InkWell(
                      onTap: () {
                        cubit.uploadCloudinaryCoverImage();
                      },
                      child: CircleAvatar(
                        radius: 25,
                        child: Icon(IconBroken.Image),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: defaultFormFiled(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String? val) => (val == null || val.isEmpty)
                        ? 'The Name Must Not be Empty'
                        : val,
                    label: 'Name',
                    prefix: IconBroken.User),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: defaultFormFiled(
                    type: TextInputType.text,
                    controller: bioController,
                    validate: (String? val) => (val == null || val.isEmpty)
                        ? 'The Bio Must Not be Empty'
                        : val,
                    label: 'Bio',
                    prefix: IconBroken.Info_Circle),
              ),
            ],
          ),
        );
      },
    );
  }
}
