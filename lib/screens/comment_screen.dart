import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/cubit/cubit.dart';
import 'package:facebook_clone/cubit/states.dart';
import 'package:facebook_clone/models/comment_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CommentScreen extends StatelessWidget {
  var commentController = TextEditingController();
  final String? postUid;

  CommentScreen(this.postUid);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return Builder(builder: (context) {
      cubit.getComments(postUid: postUid);
      return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Comments'),
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return buildCommentItem(
                            context, cubit.comments[index], index);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 10.0);
                      },
                      itemCount: cubit.comments.length,
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
                              controller: commentController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'write a comment  ... ',
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              if (commentController.text.isNotEmpty) {
                                cubit.createCommentInDatabase(
                                  createAt: Timestamp.fromDate(DateTime.now())
                                      .toString(),
                                  dateTime: DateFormat.yMMMMd()
                                      .add_Hms()
                                      .format(DateTime.now()),
                                  commentText: commentController.text,
                                  postUid: postUid.toString(),
                                );
                              }

                              commentController.text = '';
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
    });
  }

  Widget buildCommentItem(
          BuildContext context, CommentDataModel commentDataModel, index) =>
      Container(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage:
                      NetworkImage('${commentDataModel.userProfileImageUrl}'),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${commentDataModel.userName}',
                            style: Theme.of(context).textTheme.bodyText1!,
                          ),
                          Text(
                            '${commentDataModel.commentText}',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text('${commentDataModel.dateTime}'),
          ],
        ),
      );
}
