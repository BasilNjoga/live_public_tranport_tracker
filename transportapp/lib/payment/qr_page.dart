import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:transportapp/constants/routes.dart';

class QrCodeView extends StatefulWidget {
  const QrCodeView({super.key});

  @override
  State<QrCodeView> createState() => _QrCodeViewState();
}

class _QrCodeViewState extends State<QrCodeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            children: [
              const SizedBox(height: 100,),
              const Text("Success, Here is your exit code", style: TextStyle(fontSize: 33),),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: QrImageView(
                    data: '1234567890',
                    version: QrVersions.auto,
                    size: 200.0,
              ),
              ),
              
              const Text("Please scan it at the door to exit", style: TextStyle(fontSize: 15)),
              const SizedBox(height: 25,),
              FloatingActionButton.extended(onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(homeRoute, (route) => false);
          }, label: const Text("Home"))
            ],
          ),
        ),
      )
    );
  }
}