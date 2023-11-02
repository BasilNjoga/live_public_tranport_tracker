import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
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

  final startController = TextEditingController();
  final destinationController = TextEditingController();

  final startFocusNode = FocusNode();
  final destinationFocusNode = FocusNode();


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
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude),
              );
        }
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
      body : Stack (
      children: [
      GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          target: sourceLocation,
          zoom: 30.476),
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

      Positioned(
        bottom: 0,
        left: 85,
        child: SafeArea(
         bottom: true,
          child:  Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: SizedBox(
                   width: 200,
                   child: TextField(
                   controller: startController,
                   focusNode: startFocusNode,
                   decoration: const InputDecoration(
                     filled: true,
                     fillColor: Colors.white ,
                     hintText: 'Start'),
                   ),
                 ),
              ),
               Padding(
                 padding: const EdgeInsets.all(3.0),
                 child: SizedBox(
                   width: 200,
                   child: TextField(
                   controller: destinationController,
                   focusNode: destinationFocusNode,
                   decoration: const InputDecoration(
                     filled: true,
                     fillColor: Colors.white ,
                     hintText: 'Destination'),
                           
                    ),
                  ),
               ),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: FloatingActionButton.extended(
            onPressed: () {
              final latitude = double.parse(startController.text);
              final longitude = double.parse(destinationController.text);

              placemarkFromCoordinates(latitude, longitude)
              .then((placemarks) {
                var output = 'No results found';
                if (placemarks.isNotEmpty) {
                  output = placemarks[0].toString();
                }
                devtools.log(output);
              });


            },
            label: const Text("View Route"),
            icon: const Icon(Icons.directions_boat),),
        )],
          ),
         
            ),
      ),
            
        
        
        
       ],
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