import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:transportapp/models/passengers.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Passenger> futurePassenger;

  @override
  void initState() {
    super.initState();
    futurePassenger = fetchPassenger();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restful API call'),
      ),
      body: Center (
        child: FutureBuilder<Passenger>(

          future: futurePassenger,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.name);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

Future<Passenger> fetchPassenger() async {
  const uri = 'http://127.0.0.1:8000/passengers/2/';
  final response = await http.get(Uri.parse(uri));

  if (response.statusCode == 200) {
    return Passenger.fromJson(jsonDecode(response.body));
  }
  else {
    throw Exception('Failed to load users');
  }

}