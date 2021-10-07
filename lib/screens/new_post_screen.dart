import 'package:facebook_clone/cubit/cubit.dart';
import 'package:facebook_clone/cubit/states.dart';
import 'package:facebook_clone/screens/home_layout.dart';
import 'package:facebook_clone/shared/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NewPostScreen extends StatelessWidget {
  var postController = TextEditingController();
  NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {
        if (state is CreatePostSuccessState) {
          navigateAndFinish(context: context, widget: HomeLayout());
          cubit.postImageUrl = null;
        }
      },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Post'),
            actions: [
              TextButton(
                onPressed: () {
                  if (cubit.postImageUrl != null || postController.text != '') {
                    cubit.createPostInDatabase(
                        dateTime: DateFormat.yMMMMd()
                            .add_Hms()
                            .format(DateTime.now()),
                        text: postController.text);
                  } else {
                    navigateAndFinish(context: context, widget: HomeLayout());
                  }
                },
                child: const Text(
                  'POST',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              const SizedBox(width: 10.0),
            ],
          ),
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage:
                          NetworkImage('${cubit.userDataModel!.profileImage}'),
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      '${cubit.userDataModel!.name}',
                      style: Theme.of(context).textTheme.bodyText1!,
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      TextFormField(
                        maxLines: 5,
                        controller: postController,
                        decoration: const InputDecoration(
                          hintText: 'what\'s on your mind?',
                          border: InputBorder.none,
                        ),
                      ),
                      if (cubit.postImageUrl != null)
                        Container(
                          height: 150.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: NetworkImage('${cubit.postImageUrl}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .35,
                      child: defaultButton(
                        function: () {
                          cubit.getPostImage();
                        },
                        text: 'Add Photo',
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .35,
                      child: defaultButton(
                        function: () {
                          cubit.removePostImage();
                        },
                        text: 'Remove Photo',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
