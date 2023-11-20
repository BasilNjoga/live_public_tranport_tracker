import 'package:flutter/material.dart';

class MapTextField extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;
  final Icon prefixIcon;
  final Function(String) locationCallback;


  const MapTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.focusNode,
    required this.prefixIcon,
    required this.locationCallback,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  onChanged:(value) {
                    locationCallback(value);
                  },
                  controller: controller,
                  obscureText: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    prefixIcon: prefixIcon,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: hintText,
                    hintStyle: TextStyle(color: Colors.grey[500])
                  ),
                ),
              );
  }
}