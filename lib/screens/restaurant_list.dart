import 'package:flutter/material.dart';
import '../models/restaurant_model.dart';
import '../services/restaurant_api_service.dart';

class RestaurantList extends StatefulWidget {
  const RestaurantList({super.key});

  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  late Future<List<Restaurant>> futureRestaurants;
  final RestaurantApiService restaurantApiService = RestaurantApiService();

  @override
  void initState() {
    super.initState();
    futureRestaurants = restaurantApiService.getRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Restaurant>>(
        future: futureRestaurants,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Handle API error
            return Center(
                child: Text('Error loading restaurants: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            // Handle empty data
            return Center(child: Text('No restaurants available.'));
          } else {
            return Column(
              children: [
                Card(
                  elevation: 5,
                  margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const CircleAvatar(
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            const Text(
                              'Restaurants',
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
                            ),
                            IconButton(
                              icon: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Image.asset(
                                  'assets/three_line.png',
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                // Handle forward button action
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 40.0),
                          minimumSize: const Size(110.0, 50.0),
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Dine in',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle Pickup button action
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 40.0),
                          minimumSize: const Size(110.0, 50.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Pickup'),
                      ),
                    ],
                  ),
                ),
                Expanded(
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
                              Text(restaurant.foodTypeEN),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${restaurant.branchCount} Branches'),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.star,
                                          color:
                                              Color.fromARGB(255, 252, 199, 40),
                                          size: 18),
                                      const SizedBox(width: 4),
                                      Text(
                                        restaurant.rating.toStringAsFixed(1),
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
