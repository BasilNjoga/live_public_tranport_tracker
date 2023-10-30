import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:developer' as devtools;

class MainMap extends StatefulWidget {
  const MainMap({super.key});

  @override
  State<MainMap> createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();


  static const LatLng sourceLocation = LatLng(-1.071323704835, 37.04846351611011);
  static const LatLng destination = LatLng(-1.2325829357263685, 36.88116269823942);

  List<LatLng> polylineCoordinates = [];
  late LatLng currentLocation ;

  void getUserLocation() async {
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

    currentLocation = LatLng(position.latitude, position.longitude);

    setState(() {
      
    });

    devtools.log(currentLocation.toString());

  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyDA5GRgkanc2LJyzcmC62cZ9j82QgVjyKg',
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      );

      if (result.points.isNotEmpty) {
        result.points.forEach(
          (PointLatLng point) => 
              polylineCoordinates.add(LatLng(point.latitude, point.longitude),
              ),
            );
            setState(() {});
      }
  }

  @override
  void initState() {
    getPolyPoints();
    getUserLocation();
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body
      : GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          target: sourceLocation,
          zoom: 14.476),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        polylines: {
          Polyline(
            polylineId: const PolylineId("route"),
            points: polylineCoordinates,
            width: 10,
          )
        },
        markers: {
             Marker(
            markerId: const MarkerId("currentLocation"),
            position: currentLocation,
            ),
          const Marker(
            markerId: MarkerId("source"),
            position: sourceLocation,
            ),
            const Marker(
            markerId: MarkerId("destination"),
            position: destination,
            ),
        },
        ),
        
        floatingActionButton: Center(
          child: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton.extended(
            onPressed: _goToDestination,
            label: const Text('To Destination!'),
            icon: const Icon(Icons.directions_boat),
          )
        ),
        )
          );
        
  }

  Future<void> _goToDestination() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
      const CameraPosition(
        target: destination,
        zoom: 14),
        ),
      );
  }

 
}