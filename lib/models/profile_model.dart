// Data model representing the response of a user profile request
class ProfileResponse {
  // Properties to store user profile information
  final String clientName;
  final int followers;
  final int following;

  // Constructor requiring clientName, followers, and following
  ProfileResponse({
    required this.clientName,
    required this.followers,
    required this.following,
  });

  // Factory method to create a ProfileResponse instance from JSON
  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      clientName: json['client_name'],
      followers: json['followlist']['follower'],
      following: json['followlist']['following'],
    );
  }
}
