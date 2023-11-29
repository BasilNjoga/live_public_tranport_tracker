import 'package:flutter/material.dart';
import 'package:transportapp/api_connection/vehicle_location.dart';

import 'dart:developer' as devtools;

//import 'package:transportapp/models/vehicles_model.dart';


class VehicleView extends StatefulWidget {
  const VehicleView({super.key});

  @override
  State<VehicleView> createState() => _VehicleViewState();
}

class _VehicleViewState extends State<VehicleView> {

   

  

  late Future<List> vehicles;


   @override
   void initState() {
    super.initState();
    vehicles = getVehicles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
       Center(
         child: FutureBuilder(
            future: vehicles,
            builder:  (context, snapshot) {
              if (snapshot.hasData) {
                devtools.log("We're home");
                devtools.log(snapshot.data.toString());
                return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          title: Row(
                            children: [
                              const Icon(Icons.departure_board),
                              const SizedBox(width: 10,),
                              Text(snapshot.data![index]['number_plate'] + " : " + snapshot.data![index]['bus_sacco'],
                                ),
                            ],
                          ),
                    );
          });
              } else if (snapshot.hasError) {
                devtools.log("an error has occured");
                devtools.log(snapshot.error.toString());
                return Text('${snapshot.error}');
              }
       
              return const CircularProgressIndicator();
            },),
       )
    );
  }
}