import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transportapp/models/users_model.dart';
import 'package:transportapp/repository/user_repository.dart';


part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {

  AuthenticationBloc({required this.userRepository})
      : super(AuthenticationUnauthenticated()) {
        on<AppStarted>((mapAuthenticationState));
        on<LoggedIn>((mapAuthenticationState));
        on<LoggedOut>((mapAuthenticationState));
      }
 

  final UserRepository userRepository;

  Future<void> mapAuthenticationState(
    AuthenticationEvent event,
    Emitter<AuthenticationState> emit,
    ) async {
      if (event is AppStarted) {

      final bool hasToken = await userRepository.hasToken();

      if (hasToken) {
        emit(AuthenticationAuthenticated());
      } else {
        emit(AuthenticationUnauthenticated());
      }
    }

    if (event is LoggedIn) {
      emit(AuthenticationLoading());

      await userRepository.persistToken(
        user: event.user
      );
      emit(AuthenticationAuthenticated());
    }

    if (event is LoggedOut) {
      emit(AuthenticationLoading());

      await userRepository.deleteToken(id: 0);

      emit(AuthenticationUnauthenticated());
    }

    }

    }