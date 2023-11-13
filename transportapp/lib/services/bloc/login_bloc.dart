import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:transportapp/services/bloc/authentication_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transportapp/services/bloc/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    required this.userRepository,
    required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginInitial();

      try {
        final user = await userRepository.authenticate(
          email: event.emailAddre,
          password: event.password,
        );

        authenticationBloc.add(LoggedIn(user: user));
        yield LoginInitial();
      } catch (error) {
        yield LoginFaliure(error: error.toString());
      }
    }
  }
}