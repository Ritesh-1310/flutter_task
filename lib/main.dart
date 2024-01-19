// Importing necessary packages and custom screen widgets
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';

// Entry point of the application
void main() => runApp(MyApp());

// Main application class
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Disabling debug banner

      // Setting the initial screen to the LoginScreen
      home: LoginScreen(),

      // Defining named route for SignupScreen
      routes: {
        '/signup': (context) => SignupScreen(),
      },
    );
  }
}
