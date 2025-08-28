import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/components/widget_main.dart';
import 'package:social_application/cubit/social/social_cubit.dart';
import 'package:social_application/cubit/social/social_state.dart';

import 'chat_detail_screen.dart';

class ChatScreens extends StatelessWidget {
  const ChatScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = SocialCubit.get(context);
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, index) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    navigateTo(context, ChatDetailScreen(cubit.users[index]!));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                NetworkImage('${cubit.users[index]!.image}'),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${cubit.users[index]!.name}'),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_horiz,
                                size: 32, color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
            separatorBuilder: (context, index) => Container(),
            itemCount: cubit.users.length);

        return Container();
      },
    );
  }
}
