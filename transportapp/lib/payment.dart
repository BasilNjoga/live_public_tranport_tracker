import 'package:flutter/material.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});
  

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {

  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("Pay Here"),
            FloatingActionButton.extended(
              label: const Text("Pay For Trip"),
              onPressed: onPressed)
          ],
        ),
      ),
    );
  }
}