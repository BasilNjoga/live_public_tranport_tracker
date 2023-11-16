import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transportapp/authenticaton/bloc/authentication_bloc.dart';
import 'package:transportapp/login/bloc/login_bloc.dart';
import 'package:transportapp/login/login_view.dart';
import 'package:transportapp/repository/user_repository.dart';


class LoginPage extends StatelessWidget {
  final UserRepository userRepository;

  const LoginPage({Key ?key, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: const LoginView(),
      ),
    );
  }
}