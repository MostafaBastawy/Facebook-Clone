import 'package:facebook_clone/cubit/cubit.dart';
import 'package:facebook_clone/cubit/states.dart';
import 'package:facebook_clone/models/message_model.dart';
import 'package:facebook_clone/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatelessWidget {
  var messageController = TextEditingController();
  UserDataModel? userDataModel;

  ChatScreen(this.userDataModel);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return Builder(
      builder: (BuildContext context) {
        cubit.getMessages(receiverId: userDataModel!.uid!);
        return BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, Object? state) {
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 15.0,
                      backgroundImage:
                          NetworkImage('${userDataModel!.profileImage}'),
                    ),
                    const SizedBox(width: 10.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(top: 5.0),
                          child: Text(
                            '${userDataModel!.name}',
                            style: Theme.of(context).textTheme.bodyText1!,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          if (FirebaseAuth.instance.currentUser!.uid ==
                              cubit.messages[index].senderId) {
                            return buildSenderMessage(cubit.messages[index]);
                          }
                          return buildReceiverMessage(cubit.messages[index]);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 15.0);
                        },
                        itemCount: cubit.messages.length,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                controller: messageController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your message here ... ',
                                ),
                              ),
                            ),
                            MaterialButton(
                              onPressed: () {
                                if (messageController.text.isNotEmpty) {
                                  cubit.sendMessage(
                                    receiverId: userDataModel!.uid!,
                                    dateTime: DateFormat.yMMMMd()
                                        .add_Hms()
                                        .format(DateTime.now()),
                                    text: messageController.text,
                                  );
                                }

                                messageController.text = '';
                              },
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildReceiverMessage(MessageDataModel messageDataModel) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            ),
            color: Colors.grey[100],
          ),
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Text('${messageDataModel.text}'),
        ),
      );

  Widget buildSenderMessage(MessageDataModel messageDataModel) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            ),
            color: Colors.blue,
          ),
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Text(
            '${messageDataModel.text}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
}
