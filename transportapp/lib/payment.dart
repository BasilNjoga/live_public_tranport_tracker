import 'dart:async';

import 'package:flutter/material.dart';
import 'package:transportapp/constants/routes.dart';


class PaymentView extends StatefulWidget {
  const PaymentView({super.key});
  

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {


  var isLoading = false;

  void _onSubmit() {
    setState(() => isLoading = true);
    Future.delayed(
      const Duration(seconds: 6),
      () {setState(() => isLoading = false);
      Navigator.of(context).pushNamedAndRemoveUntil(qrcodeRoute, (route) => false);
  });
    
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(homeRoute, (route) => false);
                          },
                           child: const Icon(Icons.arrow_back)),
              Column(
                children: [
                  const SizedBox(height: 100,),
                  const Text("Pay Here"),
                  const SizedBox(height: 40,),
                  const Text("50", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 33),),
                  const SizedBox(height: 10,),

                  // initiate payment system

                  ElevatedButton.icon(
                      onPressed:  isLoading ? null : _onSubmit,
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16.0)),
                      icon: isLoading
                          ? Container(
                              width: 24,
                              height: 24,
                              padding: const EdgeInsets.all(2.0),
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            )
                          : const Icon(Icons.payments),
                      label: const Text('Pay for Trip'),
                    ),

                  //  FloatingActionButton.extended(
                  //   label: const Text("Pay For Trip"),
                  //   onPressed: 
                  //   // onPressed,
                  // //   () {

                  // //     const LoadingIndicator();
                  // //     //getPayment();
                  // // //  Timer(const Duration(seconds: 3), () {
                  // // //       const LoadingIndicator();
                  // // //       print("This button was pressed after 33333");
                  // // //       Navigator.of(context).pushNamedAndRemoveUntil(qrcodeRoute, (route) => false);
                  // // //    //print("This printed after 3 seconds");
                  // // //      });
                  //   ),
                  const SizedBox(height: 100,),

                  // go back to the map
                  FloatingActionButton.extended(onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(mapRoute, (route) => false);
              }, label: const Text("monitor Trip"))

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}