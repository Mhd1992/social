import 'package:flutter/material.dart';
import 'package:social_application/components/icon_broken.dart';
import 'package:social_application/components/widget_main.dart'
    show defaultTextButton;
import 'package:social_application/cubit/social/social_cubit.dart'
    show SocialCubit;

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    final cubit = SocialCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
        actions: [
          defaultTextButton(
              function: () {
                //  var postImage =
                cubit.createPost(
                    dateTime: DateTime.now().toString(),
                    text: textEditingController.text);
              },
              text: 'POST'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(
                    'assets/images/image3.png',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: TextFormField(
                controller: textEditingController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    label: Text(
                      'What is in you mind ...',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Colors.grey),
                    )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      cubit.uploadCloudinaryImage();
                    },
                    child: Row(
                      children: [
                        Icon(IconBroken.Image),
                        SizedBox(
                          width: 4,
                        ),
                        Text('Image')
                      ],
                    )),
                TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        SizedBox(
                          width: 4,
                        ),
                        Text('#Tags')
                      ],
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
