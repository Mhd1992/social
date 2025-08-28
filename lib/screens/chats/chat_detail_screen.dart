import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/components/icon_broken.dart';
import 'package:social_application/cubit/social/social_cubit.dart';
import 'package:social_application/cubit/social/social_state.dart';
import 'package:social_application/model/message_model.dart';
import 'package:social_application/model/user_model.dart';

class ChatDetailScreen extends StatelessWidget {
  UserModel userModel;

  ChatDetailScreen(this.userModel, {super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessage(receiverId: userModel.uId.toString());

      return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      userModel.image.toString(),
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    userModel.name.toString(),
                  )
                ],
              ),
            ),
            body: ConditionalBuilder(
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
              condition: SocialCubit.get(context).messages.length > 0,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            print(
                                'MainId ----> ${SocialCubit.get(context).userModel!.uId} \n');
                            print('Id ----> ${userModel.uId}');
                            if (SocialCubit.get(context).userModel!.uId !=
                                SocialCubit.get(context)
                                    .messages[index]
                                    .senderId)
                              return myMessage(
                                  SocialCubit.get(context).messages[index]);

                            return otherMessage(
                                SocialCubit.get(context).messages[index]);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                height: 3,
                              ),
                          itemCount: SocialCubit.get(context).messages.length),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hint: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Enter your message here ...'),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                SocialCubit.get(context).sendChatMessage(
                                    receiverId: userModel!.uId.toString(),
                                    text: messageController.text,
                                    dateTime: DateTime.now().toString());
                              },
                              icon: Icon(
                                IconBroken.Send,
                                color: Colors.lightBlue,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget myMessage(MessageModel message) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(message.text.toString()),
          ),
        ),
      );

  Widget otherMessage(MessageModel message) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(message.text.toString()),
          ),
        ),
      );
}
