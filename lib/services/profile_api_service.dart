// Importing necessary packages
import 'dart:convert';
import 'dart:io'; // Import for SocketException
import 'package:http/http.dart' as http;

// Class for handling profile-related API requests
class ProfileApiService {
  // Base URL for profile-related API requests
  final String baseUrl = "https://user.requeue.com";

  // Method for handling login API requests
  Future<Map<String, dynamic>> login(
      String phoneNumber, String password) async {
    try {
      // Send POST request to login endpoint
      final response = await http.post(
        Uri.parse('$baseUrl/user/auth/login'),
        body: jsonEncode({
          'phone_number': phoneNumber,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      // Check if the login was successful
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        // Throw ApiException if login fails
        throw ApiException(
            "Failed to login. Status code: ${response.statusCode}");
      }
    } on SocketException catch (e) {
      // Handle network errors
      throw ApiException("Network error: $e");
    } on FormatException catch (e) {
      // Handle JSON decoding errors
      throw ApiException("JSON decoding error: $e");
    } catch (e) {
      // Handle other errors
      throw ApiException("Failed to login. Error: $e");
    }
  }

  // Method for handling profile retrieval API requests
  Future<Map<String, dynamic>> getProfile(int clientId, int userId) async {
    try {
      // Send GET request to get-profiles endpoint
      final response = await http.get(
        Uri.parse(
            '$baseUrl/user/profiles/get-profiles?ClientID=$clientId&userid=$userId'),
      );

      // Check if the profile retrieval was successful
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw ApiException(
            "Failed to get profile. Status code: ${response.statusCode}");
      }
    } on SocketException catch (e) {
      // Handle network errors
      throw ApiException("Network error: $e");
    } on FormatException catch (e) {
      // Handle JSON decoding errors
      throw ApiException("JSON decoding error: $e");
    } catch (e) {
      // Handle other errors
      throw ApiException("Failed to get profile. Error: $e");
    }
  }
}

// Custom exception class for handling API-related errors
class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => 'ApiException: $message';
}
