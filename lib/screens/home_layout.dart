import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:facebook_clone/cubit/cubit.dart';
import 'package:facebook_clone/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: CurvedNavigationBar(
            index: cubit.currentIndex,
            height: 50.0,
            color: Colors.white,
            buttonBackgroundColor: Colors.blue,
            backgroundColor: Colors.blue,
            items: const [
              Icon(Icons.home_outlined, size: 30, color: Colors.black),
              Icon(Icons.chat, size: 30, color: Colors.black),
              Icon(Icons.person, size: 30, color: Colors.black),
            ],
            onTap: (int index) {
              cubit.changeBottomNavBar(index);
            },
          ),
        );
      },
    );
  }
}
