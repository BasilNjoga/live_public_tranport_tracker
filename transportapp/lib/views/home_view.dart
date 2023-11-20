import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:transportapp/authenticaton/bloc/authentication_bloc.dart';
import 'package:transportapp/constants/routes.dart';


import 'dart:developer' as devtools;
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  static const List _pages = [
    homeRoute,
    mapRoute,
    profileroute
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Column(children: [
            const Text('Hello there welcome to a new world'),
            ElevatedButton(onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
            }, child: const Text('View Maps')),
            ElevatedButton(onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context)
                        .add(LoggedOut());
            }, child: const Text('Log Out'))
          ]),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            onTabChange: (index) {
              devtools.log(index.toString());
              Navigator.of(context).pushNamedAndRemoveUntil(_pages[index], (route) => false);
            },
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.place,
                text: 'Travel',
              ),
              GButton(
                icon: Icons.account_circle,
                text: 'Profile'
                ),
        
            ],
          ),
        ),
      ),
    );
  }
}