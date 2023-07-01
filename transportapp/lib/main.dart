import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("Live Public Transport Tracking system"),
            ),
            backgroundColor: Colors.deepPurple[400],
        ),
        body: const Center( 
          child: Image(image: AssetImage('images/city_bus.jpg'),
          )
          
          ),
        ),
      
      ),
   
  
);
}

