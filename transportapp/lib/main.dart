import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transportapp/authenticaton/bloc/authentication_bloc.dart';
import 'package:transportapp/components/loading_indicator.dart';
import 'package:transportapp/components/splash_page.dart';
import 'package:transportapp/constants/routes.dart';
import 'package:transportapp/login/login_page.dart';
import 'package:transportapp/login/login_view.dart';
import 'package:transportapp/map.dart';
import 'package:transportapp/payment.dart';
import 'package:transportapp/payment/qr_page.dart';
import 'package:transportapp/repository/user_repository.dart';
import 'package:transportapp/vehicles.dart';
import 'package:transportapp/views/home_view.dart';
import 'dart:developer' as devtools;

import 'package:transportapp/views/register_view.dart';

void main() {
  final userRepository = UserRepository();

  runApp(
      BlocProvider<AuthenticationBloc>(
        create: (context) {
          return AuthenticationBloc(
              userRepository: userRepository
          )..add(AppStarted());
        },
        child: AuthState(userRepository: userRepository),
      )
  );
}

class AuthState extends StatelessWidget {

final UserRepository userRepository;

const AuthState({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(244, 224, 185, 1.0)),
      ),
      routes: {
        registerRoute: (coutext) => RegisterView(),
        loginRoute: (context) => const LoginView(),
        mapRoute: (context) => const MainMap(),
        homeRoute: (context) => const HomeView(),
        vehicleRoute: (context) => const VehicleView(),
        paymentRoute: (context) => const PaymentView(),
        qrcodeRoute: (context) => const QrCodeView(),
      },
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUnintialized) {
            devtools.log("not initialised authentication");
            return const SplashPage();
          }
          if (state is AuthenticationAuthenticated) {
            devtools.log("has been authenticated");
            return  const HomeView();
          }
          if (state is AuthenticationUnauthenticated) {
            devtools.log("not authenticated");
            return LoginPage(userRepository: userRepository,);
          }
          return const LoadingIndicator();
        },
      ),
    );
  }
}