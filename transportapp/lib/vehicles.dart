import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:transportapp/api_connection/vehicle_location.dart';
import 'package:transportapp/models/vehicles_model.dart';

class VehicleView extends StatefulWidget {
  const VehicleView({super.key});

  @override
  State<VehicleView> createState() => _VehicleViewState();
}

class _VehicleViewState extends State<VehicleView> {

  @override
  void initState() {
    super.initState();
    futureVehicle = getVehicles();
  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: FutureBuilder<Vehicle>(
          future: futureVehicle,
          builder:  (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },,)

        
      )
    );

  }
}