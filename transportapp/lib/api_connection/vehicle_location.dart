import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:transportapp/models/api_model.dart';

import 'dart:developer' as devtools;

import 'package:transportapp/models/vehicles_model.dart';



const _base = "127.0.0.1";
const _tokenEndpoint = "/vehicles/";

var _tokenURL = Uri(
    scheme: 'http',
    host: _base,
    path: _tokenEndpoint,
    port: 8000,
    );


Future<Vehicle> getVehicles(UserLogin userLogin) async {
  devtools.log(_tokenURL.toString());
  final http.Response response = await http.post(
    _tokenURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
  );
  if (response.statusCode == 200) {
    devtools.log("successfully got the token");
    return Vehicle.fromJson(json.decode(response.body));
  } else {
    devtools.log(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}
