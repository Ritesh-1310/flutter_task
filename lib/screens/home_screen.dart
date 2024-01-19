// Import necessary packages and files
import 'package:flutter/material.dart';
import '../models/profile_model.dart';
import '../models/restaurant_model.dart';
import '../services/profile_api_service.dart';
import '../services/restaurant_api_service.dart';
import 'restaurant_list.dart';

// HomeScreen Widget
class HomeScreen extends StatefulWidget {
  final int clientId;

  HomeScreen({super.key, required this.clientId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// _HomeScreenState Widget
class _HomeScreenState extends State<HomeScreen> {
  // Instances of profile and restaurant API services
  final ProfileApiService profileApiService = ProfileApiService();
  final RestaurantApiService restaurantApiService = RestaurantApiService();

  // Future to store profile data and restaurant list
  late Future<Map<String, dynamic>> profileData;
  late Future<List<Restaurant>> futureRestaurants;

  @override
  void initState() {
    super.initState();
    // Fetch profile and restaurant data when the widget is initialized
    profileData = profileApiService.getProfile(widget.clientId, widget.clientId);
    futureRestaurants = restaurantApiService.getRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile section widget
          ProfileSection(profileData: profileData),
          const SizedBox(height: 10),
          // Button row for navigation or actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Button to navigate to RestaurantList
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RestaurantList()),
                  );
                },
                // Button styling
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 25.0),
                  minimumSize: const Size(110.0, 50.0),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Restaurants',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              // Button for another action (e.g., messaging)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RestaurantList()),
                  );
                },
                // Button styling
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 25.0),
                  minimumSize: const Size(110.0, 50.0),
                  backgroundColor: const Color.fromARGB(255, 129, 212, 218),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Message',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Restaurant section widget
          RestaurantSection(futureRestaurants: futureRestaurants),
        ],
      ),
    );
  }
}

// ProfileSection Widget
class ProfileSection extends StatelessWidget {
  const ProfileSection({required this.profileData});

  final Future<Map<String, dynamic>> profileData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: profileData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // Handle API error
          return Center(
              child: Text('Error loading profile: ${snapshot.error}'));
        } else if (snapshot.data == null || snapshot.data!['data'].isEmpty) {
          // Handle empty data
          return const Center(child: Text('No profile data available.'));
        } else {
          // Parse profile data from the snapshot
          ProfileResponse profileResponse =
              ProfileResponse.fromJson(snapshot.data!['data'][0]);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Card displaying user profile information
              Card(
                elevation: 5,
                margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(), // Placeholder for additional content
                      const Text(
                        'Profile',
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      IconButton(
                        icon: const CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          // Handle settings button click
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Display user's profile picture and details
              const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage(
                    'assets/32c4497c4873646c6a6b043e10fa0f5e'), //profile image
              ),
              const SizedBox(height: 10),
              Text(
                profileResponse.clientName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "@Yousef",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: const Text(
                  "Obsessed with Fahim MD's, love to go shopping on weekends and loveee food #foodielife",
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 10),
              // Display user's followers and following counts
              Container(
                margin: const EdgeInsets.fromLTRB(80, 0, 80, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Followers \n ${profileResponse.followers}K',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Following \n ${profileResponse.following}K',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

// RestaurantSection Widget
class RestaurantSection extends StatelessWidget {
  const RestaurantSection({required this.futureRestaurants});

  final Future<List<Restaurant>> futureRestaurants;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>>(
      future: futureRestaurants,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Handle API error
          return Center(
              child: Text('Error loading restaurants: ${snapshot.error}'));
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          // Handle empty data
          return const Expanded(
            child: Center(child: Text('No restaurants available.')),
          );
        } else {
          // Display the list of restaurants
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final restaurant = snapshot.data![index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        "https://cdn.requeue.net/media/logos/${restaurant.logo}",
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                    title: Text(restaurant.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${restaurant.branchCount} times',
                          style: const TextStyle(color: Colors.blueAccent),
                        ),
                        const SizedBox(height: 4),
                        const Text(""), // You can add more details here
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
