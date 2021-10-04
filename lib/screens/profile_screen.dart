import 'package:facebook_clone/cubit/cubit.dart';
import 'package:facebook_clone/cubit/states.dart';
import 'package:facebook_clone/screens/edit_profile_screen.dart';
import 'package:facebook_clone/screens/login_screen.dart';
import 'package:facebook_clone/shared/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {
        if (state is UserSignOutSuccessState) {
          navigateAndFinish(context: context, widget: LoginScreen());
        }
      },
      builder: (BuildContext context, Object? state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.36,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                topLeft: Radius.circular(20.0),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                    cubit.userDataModel!.coverImage.toString()),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            height: MediaQuery.of(context).size.height * 0.51,
                            left: MediaQuery.of(context).size.width * 0.29,
                            child: CircleAvatar(
                              radius: 70.0,
                              backgroundColor: Colors.white,
                              child: Container(
                                height: 120.0,
                                width: 120.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  image: DecorationImage(
                                    image: NetworkImage(cubit
                                        .userDataModel!.profileImage
                                        .toString()),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      cubit.userDataModel!.name.toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Text(cubit.userDataModel!.bio.toString()),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    defaultButton(
                        function: () {
                          navigateTo(
                              context: context, widget: EditProfileScreen());
                        },
                        text: 'Edit Profile'),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.018),
                    defaultButton(
                        function: () {
                          cubit.signOut();
                        },
                        text: 'Logout'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
