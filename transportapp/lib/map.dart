import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:geolocator/geolocator.dart';
import 'dart:developer' as devtools;

import 'package:transportapp/getlocations.dart';

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


  String startAddress = '' ;
  String destinationAddress = '';
  
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];


  late Future<LatLng> futureLocation;

  
  Set<Marker> markers = {};





  //computer given locations and set Polyllines and Markers
  void getAddressLocations() async {
      List<Location> startLocation = await locationFromAddress(startAddress);
      List<Location> destinationLocation = await locationFromAddress(destinationAddress);

      devtools.log("StartAddress $startLocation \n StopAddress $destinationLocation");

      double startLatitude = startLocation[0].latitude;
      double startLongitude = startLocation[0].longitude;

      devtools.log("This is a the start $startLatitude");
      double destinationLatitude = destinationLocation[0].latitude;
      double destinationLongitude = destinationLocation[0].longitude;
      devtools.log("This is the end $destinationLongitude");

      await getPolyPoints(startLatitude, startLongitude, destinationLatitude, destinationLongitude);

      Marker startMarker = Marker(
        markerId: const MarkerId("startMarker"),
        position: LatLng(startLatitude, startLongitude),
        infoWindow: const InfoWindow(title: 'StartLocation'),
        icon: BitmapDescriptor.defaultMarker,
         );

      Marker destinationMarker = Marker(
        markerId: const MarkerId("destinationMarker"),
        position: LatLng(destinationLatitude, destinationLongitude),
        infoWindow: const InfoWindow(title: 'DestinationLocation'),
        icon: BitmapDescriptor.defaultMarker,
         );

      markers.add(startMarker);
      markers.add(destinationMarker);
  }
  getPolyPoints(
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {

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

  @override
  Widget build(BuildContext context) {
    //var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body :  Column(
      children: <Widget> [
      Expanded(
        flex: 7,
        child: FutureBuilder(
          future: getUserLocation(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              LatLng mydata = snapshot.data ?? const LatLng(0, 0);
              return SizedBox(
                height: 400,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: mydata,
                    zoom: 14.476),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  polylines: Set<Polyline>.of(polylines.values),
                  markers: {
                    Marker(
                  markerId: const MarkerId("startMarker"),
                  position: mydata,
                  )}
                ),
              );
             } else {
              return const Text('Loading');
            }
          }),
      ),
      

      Expanded(
        flex: 3,
        child: Positioned(
          bottom: 0,
          child: SafeArea(
           bottom: true,
           minimum: const EdgeInsets.all(6),
            child:  Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                ),
              width: width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                     // height: 100,
                       //width: 450,
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: TextField(
                         controller: startController,
                         focusNode: startFocusNode,
                         decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.person_pin_circle,
                            size: 30,),
                           filled: true,
                           fillColor: Color.fromRGBO(197,197,197, 0.4) ,
                           hintText: 'Start:'),
                         ),
                       ),
                     ),
                  ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: SizedBox(
                      //height: 75,
                       //width: 450,
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: TextField(
                         controller: destinationController,
                         focusNode: destinationFocusNode,
                         decoration: const InputDecoration(
                           border: InputBorder.none,
                           filled: true,
                           fillColor: Color.fromRGBO(197,197,197, 0.4),
                           hintText: 'Destination'),
                                 
                          ),
                       ),
                      ),
                   ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: FloatingActionButton.extended(
                          onPressed: () {
                              startAddress = startController.text;
                              destinationAddress = destinationController.text;
                              devtools.log("StartAddress: $startAddress \n StopAddress: $destinationAddress");
                              //if (markers.isNotEmpty) markers.clear();
                              //if (polylines.isNotEmpty) polylines.clear();
                              //if (polylineCoordinates.isNotEmpty) polylineCoordinates.clear();
                                
                              getAddressLocations();
                              //List<Location> startlocation = await locationFromAddress(startController.text);
                              //List<Location> stoplocation = await locationFromAddress(destinationController.text);
                          },
                          label: const Text("View Route"),
                          icon: const Icon(Icons.local_taxi_outlined),
                          ),
                      ),
                    ),
                      ],
              ),
            ),
           
              ),
        ),
      ),
            
        
        
        
       ],
    )
    );
        
  }

  
  
 
}