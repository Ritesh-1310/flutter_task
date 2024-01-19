// Importing necessary packages
import 'package:http/http.dart' as http;
import 'dart:convert';

// Class representing the response structure for API calls
class ApiResponse {
  final bool success;
  final String message;
  final dynamic data;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
  });
}

// Class representing a user
class User {
  final String clientName;

  User({
    required this.clientName,
  });
}

// Class containing methods to interact with the API
class ApiService {
  // Base URL for API requests
  static const String baseUrl = "https://user.requeue.com";

  // Method for handling login API requests
  static Future<ApiResponse> loginAPI(
      String phoneNumber, String password) async {
    const String loginEndpoint = '/user/auth/login';
    const String loginUrl = '$baseUrl$loginEndpoint';

    // Request body for login API
    final Map<String, dynamic> loginBody = {
      "phone_number": phoneNumber,
      "password": password,
    };

    try {
      // Send POST request to login endpoint
      final response = await http.post(Uri.parse(loginUrl), body: loginBody);
      final responseData = json.decode(response.body);

      // Check if the login was successful
      if (responseData['token'] != null && responseData['user'] != null) {
        // Create User object from the response data
        User user = User(
          clientName: responseData['user']['client_name'],
        );

        return ApiResponse(
            success: true, message: 'Login successful', data: user);
      } else {
        // Return ApiResponse indicating invalid credentials
        return ApiResponse(success: false, message: 'Invalid credentials');
      }
    } on http.ClientException catch (e) {
      // Handle socket errors
      return ApiResponse(success: false, message: 'Socket error: $e');
    } on FormatException catch (e) {
      // Handle JSON decoding errors
      return ApiResponse(success: false, message: 'JSON decoding error: $e');
    } catch (e) {
      // Handle other errors
      return ApiResponse(success: false, message: 'An error occurred: $e');
    }
  }

  // Method for handling signup API requests
  static Future<ApiResponse> signupAPI(
    String name,
    String email,
    String phoneNumber,
    String password,
    String country,
    String username,
  ) async {
    // Define signup endpoint and URL
    const String signupEndpoint = '/user/auth/SignUp';
    const String signupUrl = '$baseUrl$signupEndpoint';

    // Request body for signup API
    final Map<String, dynamic> signupBody = {
      "Name": name,
      "Email": email,
      "phone_number": phoneNumber,
      "Password": password,
      "Country": country,
      "UserName": username,
    };

    try {
      // Send POST request to signup endpoint
      final response = await http.post(Uri.parse(signupUrl), body: signupBody);
      final responseData = json.decode(response.body);

      // Check if the signup was successful
      if (response.statusCode == 200 && responseData['success'] == true) {
        return ApiResponse(success: true, message: 'Signup successful');
      } else {
        // Return ApiResponse with signup failure message
        return ApiResponse(
            success: false,
            message: responseData['message'] ?? 'Signup failed');
      }
    } on http.ClientException catch (e) {
      // Handle socket errors
      return ApiResponse(success: false, message: 'Socket error: $e');
    } on FormatException catch (e) {
      // Handle JSON decoding errors
      return ApiResponse(success: false, message: 'JSON decoding error: $e');
    } catch (e) {
      // Handle other errors
      return ApiResponse(success: false, message: 'An error occurred: $e');
    }
  }
}
