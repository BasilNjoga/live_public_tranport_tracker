import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:developer' as devtools;

void getMyRoute() async {

    devtools.log("you just called this function");

  //List<Location> startlocations = await locationFromAddress("Juja");
  //List<Location> stoplocations = await locationFromAddress("Thika");

  
List<Location> startlocations = await locationFromAddress("Juja");

List<Location> stoplocations = await locationFromAddress("Thika");

  devtools.log("We start at $startlocations \n and stop at $stoplocations");


}

class GetMyRoute extends StatefulWidget {
  const GetMyRoute({super.key});

  @override
  State<GetMyRoute> createState() => _GetMyRouteState();
}

class _GetMyRouteState extends State<GetMyRoute> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Column(
            children: [
              Text("This is the source and location"),
              FloatingActionButton.extended(
                label: Text("get Location"),
                onPressed: getMyRoute,
              )
            ],
          ),
        ),
      ),
    );
  }
}