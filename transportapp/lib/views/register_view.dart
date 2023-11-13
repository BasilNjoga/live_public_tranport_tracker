import 'package:flutter/material.dart';
import 'package:transportapp/components/my_botton.dart';
import 'package:transportapp/components/my_textfield.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

   // text editing controllers
    final emailAddressController = TextEditingController();
    final passwordController = TextEditingController();
    final password2Controller = TextEditingController();

  // register users method
    void registerUser() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body:  SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const SizedBox(height: 50,),
          
              const Icon(
                Icons.lock,
                size: 100,
                ),
          
              const SizedBox(height: 50,),
          
              Text(
                "Welcome to the wonderful world of busthere ",
                style: TextStyle(color: Colors.grey[700],
                fontSize: 16),
                ),
        
                const SizedBox(height: 25,),
        
                //username Textfield
                MyTextField(
                  controller: emailAddressController,
                  hintText: 'Username',
                  obscureText: false,
                ),
        
                const SizedBox(height: 15,),
        
                // Password TextField
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                
                const SizedBox(height: 15,),

                // Confirm Password TextField
                MyTextField(
                  controller: password2Controller,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
        
                const SizedBox(height: 15,),
        
        
                // Sign In
                MyRegisterButton(
                  onTap: registerUser
                ),
        
                const SizedBox(height: 50,),

                  // not a member ? register route
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already a member?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Sign in now',
                        style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ],
                    )
        
        
        
                
        
        
            ],),
          ),
        ),
      ));
  }
}