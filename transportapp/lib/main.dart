import 'package:flutter/material.dart';
import 'package:transportapp/constants/routes.dart';
import 'package:transportapp/map.dart';
import 'package:transportapp/views/home_view.dart';
import 'package:transportapp/views/register_view.dart';

void main() {
  runApp( MaterialApp(
      home: const MainMap(),
      routes: {
        registerRoute: (coutext) => RegisterView(),
        homeRoute: (context) => const HomeView(),
        mapRoute: (context) => const MainMap(),
      }
    ),
    );
}
