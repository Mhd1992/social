import 'package:flutter/material.dart';
import 'package:social_application/components/icon_broken.dart';

class FeedScreens extends StatelessWidget {
  const FeedScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 20,
            child: Stack(
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
                )
              ],
            ),
          ),
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 20,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(
                          'assets/images/image3.png',
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Mohammed Alhammali'),
                            Text(
                              'jan 21,3,2025 at 11:00 pm',
                              style: Theme.of(context).textTheme!.labelSmall,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_horiz,
                          size: 32,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.grey.shade300,
                    thickness: 2,
                  ),
                ),
                const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                      'is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book'),
                ),
                Container(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      MaterialButton(
                        onPressed: () {},
                        minWidth: 1,
                        padding: EdgeInsets.all(2),
                        child: Text('#Software'),
                      ),
                      MaterialButton(
                        onPressed: () {},
                        minWidth: 1,
                        padding: EdgeInsets.all(2),
                        child: Text('#Flutter'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            'assets/images/image3.png',
                          ),
                        )),
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
                              Icon(
                                IconBroken.Heart,
                                size: 24,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                '120',
                                style: Theme.of(context).textTheme.labelSmall,
                              )
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
                              Icon(
                                IconBroken.Chat,
                                size: 24,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                '120 comments',
                                style: Theme.of(context).textTheme.labelSmall,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.grey.shade300,
                    thickness: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(
                                'assets/images/image3.png',
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              'write a comments...',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                IconBroken.Heart,
                                size: 24,
                                color: Colors.red,
                              ),
                              Text(
                                'Like',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(color: Colors.grey),
                              ),
                              Icon(
                                IconBroken.Send,
                                size: 24,
                                color: Colors.grey,
                              ),
                              Text(
                                'Share',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
