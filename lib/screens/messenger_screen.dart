import 'package:facebook_clone/cubit/cubit.dart';
import 'package:facebook_clone/cubit/states.dart';
import 'package:facebook_clone/models/user_model.dart';
import 'package:facebook_clone/screens/chat_screen.dart';
import 'package:facebook_clone/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessengerScreen extends StatelessWidget {
  const MessengerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return buildChatItem(context, cubit.users[index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 5.0);
          },
          itemCount: cubit.users.length,
        );
      },
    );
  }

  Widget buildChatItem(BuildContext context, UserDataModel userDataModel) =>
      InkWell(
        onTap: () {
          navigateTo(
            context: context,
            widget: ChatScreen(userDataModel),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage('${userDataModel.profileImage}'),
              ),
              const SizedBox(width: 10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 11.0),
                    child: Text(
                      '${userDataModel.name}',
                      style: Theme.of(context).textTheme.bodyText1!,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios_outlined),
            ],
          ),
        ),
      );
}
