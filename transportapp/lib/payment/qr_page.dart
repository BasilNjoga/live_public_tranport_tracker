import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: QrImageView(
                    data: '1234567890',
                    version: QrVersions.auto,
                    size: 200.0,
              ),
              ),
              const Text("Hello This is your QR code"),
            ],
          ),
        ),
      )
    );
  }
}