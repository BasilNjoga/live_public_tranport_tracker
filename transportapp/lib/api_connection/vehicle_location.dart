import 'dart:async';
//import 'dart:convert' as convert;
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'dart:developer' as devtools;



const _base = "127.0.0.1";
const _tokenEndpoint = "/vehicles/";

var _tokenURL = Uri(
    scheme: 'http',
    host: _base,
    path: _tokenEndpoint,
    port: 8000,
    );
 
Future<List> getVehicleLocations() async {
   devtools.log(_tokenURL.toString());
  final locationresponse = await http.get( _tokenURL);
  if (locationresponse.statusCode == 200) {
    devtools.log("successfully got the vehicle");
    final body = locationresponse.body;
    final json = jsonDecode(body);
    final results = json as List<dynamic>;
    final locationtransformed = results.map((e) {
      e['latitude'];
      e['longitude'];
    }).toList();
    
    
    
    //var jsonResponse = convert.jsonDecode(response.body) as List<Map<String, dynamic>>;
  

   // vehicles = vehicleDetails.map((e) => e).toList();
    return locationtransformed;
  } else {
    devtools.log(json.decode(locationresponse.body).toString());
    throw Exception(json.decode(locationresponse.body));
  }
}


Future<List> getVehicles() async {
  //List<Vehicle> vehicleDetails = [];

  //List<Vehicle> vehicles = [];
  devtools.log(_tokenURL.toString());
  final response = await http.get( _tokenURL);
  if (response.statusCode == 200) {
    devtools.log("successfully got the vehicle");
    final body = response.body;
    final json = jsonDecode(body);
    final results = json as List<dynamic>;
    final transformed = results.map((e) => e).toList();
    
    
    //var jsonResponse = convert.jsonDecode(response.body) as List<Map<String, dynamic>>;
  

   // vehicles = vehicleDetails.map((e) => e).toList();
    return transformed;
  } else {
    devtools.log(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}
