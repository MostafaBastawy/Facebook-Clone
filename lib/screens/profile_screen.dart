import 'package:facebook_clone/cubit/cubit.dart';
import 'package:facebook_clone/cubit/states.dart';
import 'package:facebook_clone/screens/edit_profile_screen.dart';
import 'package:facebook_clone/shared/components.dart';
import 'package:facebook_clone/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
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
                          image: NetworkImage(defaultCoverImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      height: 400.0,
                      left: 120.0,
                      child: CircleAvatar(
                        radius: 70.0,
                        backgroundColor: Colors.white,
                        child: Container(
                          height: 120.0,
                          width: 120.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            image: DecorationImage(
                              image: NetworkImage(defaultProfileImage),
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
                'Mostafa Bastawy',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              const Text('Write your Bio...'),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              defaultButton(
                  function: () {
                    navigateTo(context: context, widget: EditProfileScreen());
                  },
                  text: 'Edit Profile'),
              SizedBox(height: MediaQuery.of(context).size.height * 0.018),
              defaultButton(function: () {}, text: 'Logout'),
            ],
          ),
        );
      },
    );
  }
}
