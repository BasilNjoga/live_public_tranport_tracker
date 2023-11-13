import 'package:flutter/material.dart';
import 'package:transportapp/constants/routes.dart';
import 'package:transportapp/map.dart';
import 'package:transportapp/views/login_view.dart';
import 'package:transportapp/views/register_view.dart';

void main() {
  runApp( MaterialApp(
      home: RegisterView(),
      routes: {
        registerRoute: (coutext) => RegisterView(),
        loginRoute: (context) => LoginView(),
        mapRoute: (context) => const MainMap(),
      }
    ),
    );
}

