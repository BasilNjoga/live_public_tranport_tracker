import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transportapp/components/my_botton.dart';
import 'package:transportapp/components/my_textfield.dart';
import 'package:transportapp/components/square_tile.dart';
import 'package:transportapp/constants/routes.dart';
import 'package:transportapp/services/bloc/login_bloc.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  

  @override
  Widget build(BuildContext context) {
    void signUserIn() {
       BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
        username: usernameController.text,
        password: passwordController.text,
       ));
  }
  return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFaliure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
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
                "Welcome back you've been missed",
                style: TextStyle(color: Colors.grey[700],
                fontSize: 16),
                ),
        
                const SizedBox(height: 25,),
        
                //username Textfield
                MyTextField(
                  controller: usernameController,
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
        
                const SizedBox(height: 10,),
        
                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password ?',
                        style: TextStyle(color: Colors.grey[600]),
                        ),
                    ],
                  ),
                ),
        
                const SizedBox(height: 25,),
        
                // Sign In
                MyLoginButton(
                  onTap: signUserIn
                ),
        
                const SizedBox(height: 40,),
        
                // Or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or Continue With',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],),
                ),
        
                const SizedBox(height: 20,),
                // Google + apple Sign In Buttons
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(imagePath: 'lib/images/google.png'),
        
                    SizedBox(width: 10),
                    // apple Button
                    SquareTile(imagePath: 'lib/images/apple.png'),
        
                  ],
                  ),
                  const SizedBox(height: 10,),
                  // not a member ? register route
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false);
                        },
                        child: const Text(
                          'Register now',
                          style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ),
                    ],
                    )
        
        
        
                
        
        
            ],),
          ),
        ),
      ));
  })
);}



}