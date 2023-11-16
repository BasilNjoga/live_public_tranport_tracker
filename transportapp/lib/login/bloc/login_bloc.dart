import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transportapp/authenticaton/bloc/authentication_bloc.dart';

import 'package:transportapp/repository/user_repository.dart';

import 'dart:developer' as devtools;



part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    required this.userRepository,
    required this.authenticationBloc,
  })  : super(LoginInitial()) {
     on<LoginButtonPressed>(mapLoginState);
     
  }
  
  Future<void> mapLoginState(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
    ) async {
    emit(LoginInitial());

    try {
      final user = await userRepository.authenticate(
        email: event.email,
        password: event.password,
      );

      devtools.log('successfully authenticated');
      authenticationBloc.add(LoggedIn(user: user));
      emit(LoginInitial());
    } catch (error) {
      devtools.log('here is the error');
      devtools.log(error.toString());
      emit(LoginFaliure(error: error.toString()));
    }
      }

  Stream<LoginState> mapEventToState(
      LoginEvent event,
      ) async* {
 
  }
}
