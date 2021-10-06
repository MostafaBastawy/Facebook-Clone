import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:facebook_clone/cubit/cubit.dart';
import 'package:facebook_clone/cubit/states.dart';
import 'package:facebook_clone/models/post_model.dart';
import 'package:facebook_clone/screens/new_post_screen.dart';
import 'package:facebook_clone/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {
        if (state is GetPostsSuccessState) {
          cubit.getUserData();
        }
      },
      builder: (BuildContext context, Object? state) {
        return ConditionalBuilder(
          condition: cubit.posts.isNotEmpty && cubit.userDataModel != null,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //This section for creating new posts
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25.0,
                          backgroundImage: NetworkImage(
                              '${cubit.userDataModel!.profileImage}'),
                        ),
                        const SizedBox(width: 10.0),
                        TextButton(
                          onPressed: () {
                            navigateTo(
                                context: context, widget: NewPostScreen());
                          },
                          child: Text(
                            'Whats on your mind?',
                            style: Theme.of(context).textTheme.bodyText1!,
                          ),
                        ),
                      ],
                    ),
                  ),
                  myDivider(),
                  //This section for listing new stories
                  Container(
                    height: 200.0,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return buildStoryItem();
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(width: 10.0);
                      },
                      itemCount: 10,
                    ),
                  ),
                  myDivider(),
                  //This section for listing new posts
                  ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return buildPostItem(context, cubit.posts[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return myDivider();
                    },
                    itemCount: cubit.posts.length,
                  ),
                ],
              ),
            );
          },
          fallback: (BuildContext context) {
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }

  Widget buildMyStoryItem(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          bottom: 10.0,
          left: 20.0,
          top: 10.0,
        ),
        child: Container(
          width: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.grey[100],
            border: Border.all(
              color: Colors.grey.withOpacity(0.7),
            ),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 110.0,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://pbs.twimg.com/profile_images/1209274176906752000/5Lne-grQ_400x400.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: Text(
                      'Create \n Story',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
              Positioned(
                top: 87.0,
                left: 25.0,
                child: Container(
                  height: 45.0,
                  width: 45.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Center(
                    child: Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.blue[800],
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildStoryItem() => Padding(
        padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
        child: Stack(
          children: [
            Container(
              width: 100.0,
              height: 180.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey[100],
                border: Border.all(
                  color: Colors.grey.withOpacity(0.7),
                ),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: 5.0,
              left: 5.0,
              child: Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Center(
                  child: Container(
                    height: 45.0,
                    width: 45.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: const Image(
                      image: NetworkImage(
                          'https://cdn.pixabay.com/photo/2014/04/03/10/50/egyptian-311457_960_720.png'),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 8.0,
              bottom: 8.0,
              child: Container(
                width: 80.0,
                height: 30.0,
                child: const Text(
                  'Cameroon Jho',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildPostItem(BuildContext context, PostDataModel postDataModel) =>
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage('${postDataModel.image}'),
                ),
                const SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${postDataModel.name}',
                      style: Theme.of(context).textTheme.bodyText1!,
                    ),
                    Text('${postDataModel.dateTime}'),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              child: Text(
                '${postDataModel.text}',
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          if (postDataModel.postImage == '') const SizedBox(height: 10.0),
          if (postDataModel.postImage != '')
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                height: 150.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('${postDataModel.postImage}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: const [
                Text('120 Likes'),
                Spacer(),
                Text('120 Comments'),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              height: 1.0,
              width: double.infinity,
              color: Colors.grey[100],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              children: [
                Row(
                  children: const [
                    Icon(Icons.favorite_border),
                    const SizedBox(width: 8.0),
                    Text('Like'),
                  ],
                ),
                const Spacer(),
                Row(
                  children: const [
                    Icon(Icons.chat_bubble_outline),
                    SizedBox(width: 8.0),
                    Text('Comment'),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
}
