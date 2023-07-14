import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

class MapsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var appState = context.watch<MyAppState>();
    return Scaffold(
        body: Column(
      children: [
        Text('Choose drop off and pick up point'),
        Image(height: 400, image: AssetImage('images/map_example.png')),
        ElevatedButton(
            onPressed: () {
              print('button pressed!');
            },
            child: Text('Confirm Pickup')),
      ],
    ));
  }
}
