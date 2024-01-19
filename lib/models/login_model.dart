// Data model representing the response of a login request
class LoginResponse {
  // Properties to store client information
  final String clientName;
  final int clientId;

  // Constructor requiring clientName and clientId
  LoginResponse({
    required this.clientName,
    required this.clientId,
  });

  // Factory method to create a LoginResponse instance from JSON
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      // Mapping 'client_name' from JSON to clientName property
      clientName: json['client_name'],

      // Mapping 'client_id' from JSON to clientId property
      clientId: json['client_id'],
    );
  }
}
