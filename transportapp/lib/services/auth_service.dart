import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transportapp/models/api_model.dart';

import 'dart:developer' as devtools;


class AuthService extends StatelessWidget {
  const AuthService({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
     // body: StreamBuilder<User?>
    );
  }
}

const  _base = "http://127.0.0.1:8000";
const _tokenEndpoint = "/users/register/";
const _tokenURL = _base + _tokenEndpoint;

Future<Token> getToken(UserLogin userLogin) async {
  devtools.log(_tokenURL);
  final http.Response response = await http.post(
    _tokenURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
  );
  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    devtools.log(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}