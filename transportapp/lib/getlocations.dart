import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:developer' as devtools;

Future<LatLng> getUserLocation() async {
     bool serviceEnabled;
  LocationPermission permission;

  // Test if permissions and location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) { 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    LatLng currentLocation = LatLng(position.latitude, position.longitude);

    

    devtools.log(currentLocation.toString());

    return currentLocation;

  }