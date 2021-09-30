import 'package:facebook_clone/cubit/cubit.dart';
import 'package:facebook_clone/cubit/states.dart';
import 'package:facebook_clone/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //This section for creating new posts
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                        'https://pbs.twimg.com/profile_images/1209274176906752000/5Lne-grQ_400x400.jpg'),
                  ),
                  const SizedBox(width: 10.0),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Whats on your mind?',
                      style: Theme.of(context).textTheme.bodyText1!,
                    ),
                  ),
                ],
              ),
            ),
            myDivider(),
            //This Card for creating new story
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 180.0,
                width: 100.0,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Container(
                          height: 110.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                            image: const DecorationImage(
                              image: NetworkImage(
                                'https://pbs.twimg.com/profile_images/1209274176906752000/5Lne-grQ_400x400.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 17.0,
                          backgroundColor: Colors.grey[100],
                          child: const CircleAvatar(
                            radius: 15.0,
                            backgroundColor: Colors.blue,
                            child: Icon(Icons.add,
                                size: 25.0, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height:10.0),
                    Center(
                      child: Text(
                        'Create \n Story',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
