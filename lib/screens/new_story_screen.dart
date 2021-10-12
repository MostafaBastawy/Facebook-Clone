import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/cubit/cubit.dart';
import 'package:facebook_clone/cubit/states.dart';
import 'package:facebook_clone/screens/home_layout.dart';
import 'package:facebook_clone/shared/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NewStoryScreen extends StatelessWidget {
  NewStoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {
        if (state is CreateStorySuccessState) {
          navigateAndFinish(context: context, widget: HomeLayout());
          cubit.storyImageUrl = null;
        }
      },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Story'),
            actions: [
              TextButton(
                onPressed: () {
                  if (cubit.storyImageUrl != null) {
                    cubit.createStoryInDatabase(
                      createAt: Timestamp.fromDate(DateTime.now()).toString(),
                      dateTime:
                          DateFormat.yMMMMd().add_Hms().format(DateTime.now()),
                    );
                  } else {
                    navigateAndFinish(context: context, widget: HomeLayout());
                  }
                },
                child: const Text(
                  'Create',
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                if (cubit.storyImageUrl != null)
                  Container(
                    height: 300.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage('${cubit.storyImageUrl}'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .39,
                      child: defaultButton(
                        function: () {
                          cubit.getStoryImage();
                        },
                        text: 'Add Photo',
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .39,
                      child: defaultButton(
                        function: () {
                          cubit.removeStoryImage();
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
