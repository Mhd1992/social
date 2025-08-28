import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_application/components/icon_broken.dart';
import 'package:social_application/cubit/social/social_cubit.dart';
import 'package:social_application/cubit/social/social_state.dart';

class FeedScreens extends StatelessWidget {
  const FeedScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = SocialCubit.get(context);

        if (state is GetPostLoadingState)
          return Center(child: CircularProgressIndicator());

        return ListView.separated(
          itemCount: cubit.posts.length, // Change this based on your data
          separatorBuilder: (context, index) =>
              Divider(color: Colors.grey.shade300, thickness: 2),
          itemBuilder: (context, index) {
            return Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 20,
              child: Column(
                children: [
                  // Image and title for the first card
                  if (index == 0) ...[
                    Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Image.asset(
                          'assets/images/image.png',
                          fit: BoxFit.cover,
                          height: 250,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Communicate With Friends',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                  // Content for other cards
                  // if (index > 0) ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              NetworkImage('${cubit.userModel?.image}'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${cubit.posts[index].name}'),
                              Text(
                                  formatDateTime(DateTime.parse(
                                      cubit.posts[index].dateTime.toString())),
                                  style:
                                      Theme.of(context).textTheme.labelSmall),
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
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('${cubit.posts[index].text}'),
                  ),
                  Container(
                    width: double.infinity,
                    child: Wrap(
                      children: [
                        MaterialButton(
                            onPressed: () {},
                            minWidth: 1,
                            padding: EdgeInsets.all(2),
                            child: Text('#Software')),
                        MaterialButton(
                            onPressed: () {},
                            minWidth: 1,
                            padding: EdgeInsets.all(2),
                            child: Text('#Flutter')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: cubit.posts[index].postImage!.isEmpty
                        ? Container()
                        : Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      cubit.posts[index].postImage.toString())),
                            ),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                Icon(Icons.favorite,
                                    size: 24, color: Colors.red),
                                SizedBox(width: 6),
                                Text('120',
                                    style:
                                        Theme.of(context).textTheme.labelSmall),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.comment,
                                    size: 24, color: Colors.amber),
                                SizedBox(width: 6),
                                Text('120 comments',
                                    style:
                                        Theme.of(context).textTheme.labelSmall),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  NetworkImage('${cubit.userModel?.image}'),
                            ),
                            SizedBox(width: 6),
                            Text(
                              'write a comments...',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        bool? liked = cubit.posts[index].liked;

                                        cubit.updatePostLikeState(
                                            cubit.posts[index].postId
                                                .toString(),
                                            !liked!);
                                        //       cubit.likePost(state.postModels[index]!.postId.toString());
                                      },
                                      child: Icon(IconBroken.Heart,
                                          size: 24,
                                          color:
                                              (cubit.posts[index].liked == true)
                                                  ? Colors.red
                                                  : Colors.grey)),
                                  Text('Like',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(color: Colors.grey)),
                                ],
                              ),
                              /*

                              To Share post with specific people
                              Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        cubit.likePost(cubit.likes[index]);
                                      },
                                      child: Icon(Icons.share,
                                          size: 24, color: Colors.grey),
                                    ),
                                    Text('Share',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(color: Colors.grey)),
                                  ],
                                ),*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                //],
              ),
            );
          },
        );

        return Container();
      },
    );
  }
}

String formatDateTime(DateTime dateTime) {
  final DateFormat formatter = DateFormat('MMM dd, yyyy ' 'at h:mm a');
  return formatter.format(dateTime);
}
