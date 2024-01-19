// Importing necessary packages and the Restaurant model
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/restaurant_model.dart';

// Class for handling restaurant-related API requests
class RestaurantApiService {
  // Base URL for restaurant-related API requests
  static const String baseUrl = 'https://user.requeue.com/user/mainpages';

  // Method for handling restaurant retrieval API requests
  Future<List<Restaurant>> getRestaurants() async {
    try {
      const uri =
          '$baseUrl/get-restaurants?PickupAvailable=1&AreaName=Kuwait&page=1&page_limit=10';

      // Send GET request to get-restaurants endpoint
      final response = await http.get(Uri.parse(uri));

      // Check if the restaurant retrieval was successful
      if (response.statusCode == 200) {
        // Decode the JSON response
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> restaurantsData = data['data'];

        // Map JSON data to a list of Restaurant objects
        return restaurantsData
            .map((json) => Restaurant.fromJson(json))
            .toList();
      } else {
        // Throw HttpException if restaurant retrieval fails
        throw HttpException('Failed to load restaurants. Status code: ${response.statusCode}');
      }
    } on SocketException catch (e) {
      // Handle network errors
      throw ApiException('Network error: $e');
    } on FormatException catch (e) {
      // Handle JSON decoding errors
      throw ApiException('JSON decoding error: $e');
    } catch (e) {
      // Handle other errors
      throw ApiException('Failed to load restaurants. Error: $e');
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
