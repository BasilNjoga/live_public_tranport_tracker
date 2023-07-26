import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Live Transport App',
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
                seedColor: Color.fromRGBO(244, 224, 185, 1.0))),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {}

// ...

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = MapsPage();
        break;
      case 2:
        page = Placeholder();
        break;
      case 3:
        page = Placeholder();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home,
                        color: Color.fromRGBO(46, 56, 64, 1.0)),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.place,
                        color: Color.fromRGBO(46, 56, 64, 1.0)),
                    label: Text('Maps'),
                  ),
                  NavigationRailDestination(
                      icon: Icon(Icons.update,
                          color: Color.fromRGBO(46, 56, 64, 1.0)),
                      label: Text('Activity')),
                  NavigationRailDestination(
                      icon: Icon(Icons.account_circle_outlined,
                          color: Color.fromRGBO(46, 56, 64, 1.0)),
                      label: Text('Account')),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var appState = context.watch<MyAppState>();
    final theme = Theme.of(context);
    final style = theme.textTheme.titleMedium!.copyWith(
      color: Color.fromRGBO(46, 56, 64, 1.0),
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text("Public Transport Tracker",
                  style: theme.textTheme.displayLarge!),
            ),
          ),
          Image(height: 200, image: AssetImage('images/city_bus.jpg')),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text("Convinience and Comfort for Every ride",
                    textAlign: TextAlign.center, style: style)),
          ),
        ],
      ),
    );
  }
}

class MapsPage extends State<MyApp> {
  late GoogleMapController mapController;

  final LatLng sourceLocation =
      const LatLng(-1.0909771979474097, 37.01120191308141);
  final LatLng destination =
      const LatLng(-1.1248462242034525, 37.00324046871465);
  final String googleApiKey = "AIzaSyDA5GRgkanc2LJyzcmC62cZ9j82QgVjyKg";

  List<LatLng> polylineCoordinates = [];

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude));

    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          elevation: 2,
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: sourceLocation,
            zoom: 14.5,
          ),
          polylines: {
            Polyline(
              polylineId: PolylineId("route"),
              points: polylineCoordinates,
            ),
          },
          markers: {
            Marker(
                markerId: const MarkerId("source"), position: sourceLocation),
            Marker(
                markerId: const MarkerId("destination"), position: destination)
          },
        ),
      ),
    );
  }
}
