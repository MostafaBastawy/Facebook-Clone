import 'package:facebook_clone/cubit/cubit.dart';
import 'package:facebook_clone/cubit/states.dart';
import 'package:facebook_clone/shared/components.dart';
import 'package:facebook_clone/shared/constants.dart';
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
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit Profile'),
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
                            function: () {}, text: 'Change Profile'),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * .47,
                          child: defaultButton(
                              function: () {}, text: 'Change Cover')),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  defaultButton(function: () {}, text: 'Apply Edit'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
