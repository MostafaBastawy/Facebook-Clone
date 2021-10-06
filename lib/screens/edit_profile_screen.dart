import 'package:facebook_clone/cubit/cubit.dart';
import 'package:facebook_clone/cubit/states.dart';
import 'package:facebook_clone/screens/home_layout.dart';
import 'package:facebook_clone/shared/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    nameController.text = cubit.userDataModel!.name.toString();
    phoneController.text = cubit.userDataModel!.phone.toString();
    bioController.text = cubit.userDataModel!.bio.toString();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {
        if (state is UpdateUserDataSuccessState) {
          navigateAndFinish(context: context, widget: HomeLayout());
        }
      },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
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
                              image: cubit.coverImage == null
                                  ? NetworkImage(
                                      '${cubit.userDataModel!.coverImage}')
                                  : FileImage(cubit.coverImage!)
                                      as ImageProvider,
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
                                  image: cubit.profileImage == null
                                      ? NetworkImage(
                                          '${cubit.userDataModel!.profileImage}')
                                      : FileImage(cubit.profileImage!)
                                          as ImageProvider,
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    validator: (String? value) {},
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                    onTap: () {},
                    onChanged: (String value) {},
                    onFieldSubmitted: (value) {},
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  TextFormField(
                    controller: bioController,
                    keyboardType: TextInputType.text,
                    validator: (String? value) {},
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Bio',
                      prefixIcon: Icon(Icons.animation),
                    ),
                    onTap: () {},
                    onChanged: (value) {},
                    onFieldSubmitted: (value) {},
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (String? value) {},
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    onTap: () {},
                    onChanged: (value) {},
                    onFieldSubmitted: (value) {},
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .47,
                        child: defaultButton(
                          function: () {
                            cubit.getProfileImage();
                          },
                          text: 'Change Profile',
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .47,
                        child: defaultButton(
                          function: () {
                            cubit.getCoverImage();
                          },
                          text: 'Change Cover',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  defaultButton(
                    function: () {
                      cubit.updateUserData(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                      );
                    },
                    text: 'Save Changes',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
