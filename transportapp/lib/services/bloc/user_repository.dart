import 'dart:async';
import 'package:transportapp/models/api_model.dart';
import 'package:transportapp/models/users_model.dart';
import 'package:transportapp/services/auth_service.dart';
import 'package:transportapp/services/user_dao.dart';

class UserRepository {
  final userDao = UserDao();

  Future<User> authenticate ({
    required String email,
    required String password,
  }) async {
    UserLogin userLogin = UserLogin(
        email: email,
        password: password
    );
    Token token = await getToken(userLogin);
    User user = User(
      id: 0,
      email: email,
      token: token.token,
    );
    return user;
  }

  Future<void> persistToken ({
    required User user
  }) async {
    // write token with the user to the database
    await userDao.createUser(user);
  }

  Future <void> deleteToken({
    required int id
  }) async {
    await userDao.deleteUser(id);
  }

  Future <bool> hasToken() async {
    bool result = await userDao.checkUser(0);
    return result;
  }
}