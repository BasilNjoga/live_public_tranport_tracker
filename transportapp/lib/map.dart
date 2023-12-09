import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:transportapp/components/map_text_field.dart';
import 'package:transportapp/constants/routes.dart';
import 'dart:developer' as devtools;

import 'package:transportapp/getlocations.dart';


class MainMap extends StatefulWidget {
  const MainMap({super.key});

  @override
  State<MainMap> createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  late GoogleMapController mapController;

  final startController = TextEditingController();
  final destinationController = TextEditingController();

  final startFocusNode = FocusNode();
  final destinationFocusNode = FocusNode();


  String startAddress = 's' ;
  String destinationAddress = 't';

  String? placeDistance;
  int travelPrice = 0;

  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];


  late Future<LatLng> futureLocation;

  
  Set<Marker> markers = {};


  //computer given locations and set Polyllines and Markers
   Future<bool> getAddressLocations() async {
    try {
      
      List<Location> startLocation = await locationFromAddress(startAddress);
      devtools.log("this is the startlocation: $startLocation");
      List<Location> destinationLocation = await locationFromAddress(destinationAddress);
      devtools.log("This is the final locations: $destinationLocation");

      devtools.log("StartAddress $startLocation \n StopAddress $destinationLocation");

      double startLatitude = startLocation[0].latitude;
      double startLongitude = startLocation[0].longitude;

      devtools.log("This is a the start $startLatitude");
      double destinationLatitude = destinationLocation[0].latitude;
      double destinationLongitude = destinationLocation[0].longitude;
      devtools.log("This is the end $destinationLongitude");

      // Start Location Marker
      Marker startMarker = Marker(
        markerId: const MarkerId("startMarker"),
        position: LatLng(startLatitude, startLongitude),
        infoWindow: const InfoWindow(title: 'StartLocation'),
        icon: BitmapDescriptor.defaultMarker,
         );

      // Destination Location Marker
      Marker destinationMarker = Marker(
        markerId: const MarkerId("destinationMarker"),
        position: LatLng(destinationLatitude, destinationLongitude),
        infoWindow: const InfoWindow(title: 'DestinationLocation'),
        icon: BitmapDescriptor.defaultMarker,
         );

      markers.add(startMarker);
      markers.add(destinationMarker);


      // double miny = (startLatitude <= destinationLatitude)
      //     ? startLatitude
      //     : destinationLatitude;
      // double minx = (startLongitude <= destinationLongitude)
      //     ? startLongitude
      //     : destinationLongitude;
      // double maxy = (startLatitude <= destinationLatitude)
      //     ? destinationLatitude
      //     : startLatitude;
      // double maxx = (startLongitude <= destinationLongitude)
      //     ? destinationLongitude
      //     : startLongitude;

      // double southWestLatitude = miny;
      // double southWestLongitude = minx;

      // double northEastLatitude = maxy;
      // double northEastLongitude = maxx;
      // devtools.log("changing controller");


      // mapController.animateCamera(
      //   CameraUpdate.newLatLngBounds(
      //     LatLngBounds(
      //       northeast: LatLng(northEastLatitude, northEastLongitude),
      //       southwest: LatLng(southWestLatitude, southWestLongitude),
      //     ),
      //     100.0,
      //   ),
      // );

      await getPolyPoints(startLatitude, startLongitude, destinationLatitude, destinationLongitude);

      double totalDistance = 0.0;
      
      for (int i = 0; i < 4; i++) {
        totalDistance += _calculateDistance(
          startLatitude,
          startLongitude,
          destinationLatitude,
          destinationLongitude);
      }
      
      setState(() {
        placeDistance = totalDistance.toStringAsFixed(2);
        travelPrice = 80;
        devtools.log("Distance: $placeDistance");
      });
      
      return true;
    } catch (e) {
      devtools.log(e.toString());
    }
   return false;
  }
  getPolyPoints(
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    
    devtools.log("Trying to get polylines");
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyDA5GRgkanc2LJyzcmC62cZ9j82QgVjyKg',
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.transit,
      );

      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude),
              );
        }
      
      PolylineId id = const PolylineId("routes");
      Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.black,
        points: polylineCoordinates,
        width: 6,
        );
        polylines[id] = polyline;
      }
  }

  @override
  void initState() {
    //myLocationData = getUserLocation();
    super.initState();
  }

  double _calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
        return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    //var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body :  Column(
      children: <Widget> [
      
      Expanded(
        flex: 6,
        child: FutureBuilder(
          future: getUserLocation(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              LatLng mydata = snapshot.data?[1] ?? const LatLng(0, 0);
              markers.add(snapshot.data?[0]);
              return SizedBox.expand(
                child: Stack(
                  children:[
                    // Map View
                    GoogleMap(
                    mapType: MapType.normal,
                    markers: Set<Marker>.from(markers),
                    polylines: Set<Polyline>.of(polylines.values),
                    initialCameraPosition: CameraPosition(
                      target: mydata,
                      zoom: 14.476),
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                    },
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 10,),
                      SafeArea(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(homeRoute, (route) => false);
                          },
                           child: const Icon(Icons.arrow_back)),
                      ),
                      const Spacer(),
                       SafeArea(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(vehicleRoute, (route) => false);
                      },
                       child: const Icon(Icons.directions_bus)),
                  ),
                    const SizedBox(width: 10,),
                    ],
                    
                  ),
                 
                  ],
                ),
              );
             } else {
              return const Text('Loading');
            }
          }),
      ),
      
      
      Expanded(
        flex: 4,
        child: SafeArea(
        //  bottom: true,
            top: false,
        //  minimum: const EdgeInsets.all(0),
          child:  Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              ),
            width: width,
            child: Column(
              children: [
                MapTextField(
                controller: startController,
                focusNode: startFocusNode,
                hintText: 'Start:',
                prefixIcon: const Icon(
                   Icons.person_pin_circle,
                   size: 30,
                   ),
                 locationCallback: (String value) {
                       setState(() {
                         startAddress = value;
                       });
                     }
                ),
                 MapTextField(
                 controller: destinationController,
                 focusNode: destinationFocusNode,
                 hintText: 'Destination:',
                 prefixIcon: const Icon(
                    Icons.person_pin_circle,
                    size: 30,
                    ),
                  locationCallback: (String value) {
                        setState(() {
                          destinationAddress = value;
                        });
                      }
                 ),
                 const SizedBox(height: 1,),
                 Text('DISTANCE: $placeDistance km',
                 style: const TextStyle(
                   fontSize: 16,
                   fontWeight: FontWeight.bold,
                 )),
                 const SizedBox(height: 5,),
                 Text('PRICE: $travelPrice Ksh',
                 style: const TextStyle(
                   fontSize: 16,
                   fontWeight: FontWeight.bold,
                 )),
      
                  const SizedBox(height: 5,),
      
                  SizedBox(
                    child: FloatingActionButton.extended(
                      onPressed: 
                      (startAddress != '' && 
                                  destinationAddress != '') 
                        ? () async {
                          
                          startFocusNode.unfocus();
                          destinationFocusNode.unfocus();
      
                          setState(() {
                                  if (markers.isNotEmpty) markers.clear();
                                  if (polylines.isNotEmpty)
                                    {
                                      polylines.clear();
                                      }
                                  if (polylineCoordinates.isNotEmpty)
                                    { 
                                      polylineCoordinates.clear();
                                    }
                                });
                        getAddressLocations()
                            .then((isCalculated) {
                              if (isCalculated) {
                                ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Distance Calculated Sucessfully'),
                                      ),
                              ); } else {
                                ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Error Calculating Distance'),
                                      ),
                                    );
                              }
                              }
                            );
                      } : null,
                      label: const Text("View Route"),
                      icon: const Icon(Icons.local_taxi_outlined),
                      ),
                  ),
                    ],
            ),
          ),
         
            ),
      ),
            
        
        
        
       ],
        )
    );
        
  }

  
  
 
}