import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:facebook_clone/cubit/cubit.dart';
import 'package:facebook_clone/cubit/states.dart';
import 'package:facebook_clone/screens/home_layout.dart';
import 'package:facebook_clone/screens/register_screen.dart';
import 'package:facebook_clone/shared/components.dart';
import 'package:facebook_clone/shared/shared_prefrence.dart';
import 'package:facebook_clone/shared/show_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {
        if (state is UserLoginSuccessState) {
          defaultToast(
            message: 'Login successfully',
            color: Colors.green,
            context: context,
          );
          CacheHelper.setData(
              key: 'uid', value: FirebaseAuth.instance.currentUser!.uid);
          navigateAndFinish(context: context, widget: HomeLayout());
        }
      },
      builder: (BuildContext context, Object? state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Facebook'),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login to Facebook',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'field is empty';
                          }
                          String pattern = r'\w+@\w+\.\w+';
                          if (!RegExp(pattern).hasMatch(value)) {
                            return 'invalid email address format';
                          }
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email Address',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        onTap: () {},
                        onChanged: (value) {},
                        onFieldSubmitted: (value) {},
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'field is empty';
                          }
                          String pattern =
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                          if (!RegExp(pattern).hasMatch(value)) {
                            return 'invalid password format';
                          }
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                        ),
                        onTap: () {},
                        onChanged: (value) {},
                        onFieldSubmitted: (value) {},
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      ConditionalBuilder(
                        condition: state is! UserLoginLoadingState,
                        builder: (BuildContext context) => defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          text: 'LOGIN',
                          color: Colors.white,
                        ),
                        fallback: (BuildContext context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Dont have an account?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                              color: Colors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              navigateTo(
                                  context: context, widget: RegisterScreen());
                            },
                            child: const Text('Register'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
