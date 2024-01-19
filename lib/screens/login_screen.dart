// Importing necessary packages and files
import 'dart:io';
import 'package:flutter/material.dart';
import '../services/profile_api_service.dart';
import '../models/login_model.dart';
import 'home_screen.dart';
import 'signup_screen.dart';

// Class representing the Login screen
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  // Instance of the ProfileApiService class for handling API requests
  final ProfileApiService profileApiService = ProfileApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Image.asset(
                  'assets/029f3af30479b69c3949088f5547381e',
                  height: 150,
                  width: 150,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    margin: const EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.white70.withOpacity(0.3),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Login your account',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 50,
                            child: TextField(
                              controller: phoneNumberController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                prefixIcon: const Icon(Icons.phone),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 50,
                            child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                // Implement the forgot password action
                              },
                              child: const Text(
                                'Forgot your password?',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              _login();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              minimumSize: const Size(double.infinity, 50),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text(
                              "Login",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("You don't have an account yet!",
                          style: TextStyle(color: Colors.white)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100.0,
                        height: 2.0,
                        color: Colors.white,
                      ),
                      const SizedBox(
                          width:
                              10.0),
                      const Text(
                        'login with',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                          width:
                              10.0),
                      Container(
                        width: 100.0,
                        height: 2.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Login with third-party buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildRoundIconButton(
                          'assets/google_logo.png', Colors.white), // google
                      buildRoundIconButton(
                          'assets/apple_logo4.png', Colors.white), // apple
                      buildRoundIconButton(
                          'assets/facebook_logo.png', Colors.white), // facebook
                      buildRoundIconButton(
                          'assets/twitter_logo.png', Colors.white), // twitter
                    ],
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build a round icon button with given icon data and color
  Widget buildRoundIconButton(String iconData, Color color) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: IconButton(
        icon: Image.asset(
          iconData,
          height: 45,
          width: 45,
        ),
        onPressed: () {
          // Handle button press
        },
        color: Colors.white,
      ),
    );
  }

  // Perform the login action
  void _login() async {
    try {
      // Call the login API
      final response = await profileApiService.login(
        phoneNumberController.text,
        passwordController.text,
      );

      // Check the API response
      if (response['message'] == 'User Login SuccessFully') {
        // Create a LoginResponse object from the API response
        LoginResponse loginResponse = LoginResponse.fromJson(response['user']);
        
        // Navigate to the HomeScreen with the clientId
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(clientId: loginResponse.clientId),
          ),
        );
      } else {
        // Show error message if login fails
        _showError('Login failed. Please check your credentials.');
      }
    } on SocketException catch (e) {
      // Show error message for network errors
      _showError('Network error. Please check your internet connection.');
      print('Login error: $e');
    } on ApiException catch (e) {
      // Show error message for API errors
      _showError('API error: ${e.message}');
    } catch (e) {
      // Show error message for other unexpected errors
      _showError('An unexpected error occurred. Please try again later.');
      print('Login error: $e');
    }
  }

  // Show a snackbar with the given error message
  void _showError(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
      ),
    );
  }
}
