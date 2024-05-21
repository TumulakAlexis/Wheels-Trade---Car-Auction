import 'package:flutter/material.dart';

class Pickup extends StatefulWidget {
  const Pickup({super.key});

  @override
  State<Pickup> createState() => _PickupState();
}

class _PickupState extends State<Pickup> {
  final List<String> suvAuctionImages = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1DlYbm0HBvQfhgtz_CVfC3s0vK6CehIYe1QIYV5H8ag&s',  // Replace with actual image URLs
    'https://malaya.com.ph/wp-content/uploads/2022/06/22MY_STRADA_4WD.jpg',
    'https://cdn.motor1.com/images/mgl/013Gp/s1/2021-nissan-navara-facelift.jpg',
  ];

  List<String> itemLabels = [
    'Toyota Hilux 2024',
    'Mitsubishi Strada',
    'Nissan Navara 2021',
  ];

  List<String> itemDescriptions = [
    'Starting Bid: P2,000,000',
    'Starting Bid: P3,000,000',
    'Starting Bid: P1,500,000',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 50, 20, 30),
        child: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "On Going Auctions.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Color.fromARGB(255, 79, 99, 110),
                ),
              ),
              SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true, // Add shrinkWrap to GridView
                physics: NeverScrollableScrollPhysics(), // Disable GridView's scrolling
                itemCount: suvAuctionImages.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 10, // Space between columns
                  mainAxisSpacing: 10, // Space between rows
                ),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.blueGrey,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            suvAuctionImages[index],
                            fit: BoxFit.cover, // Ensures the image covers the entire container
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(Icons.error, color: Colors.red),
                              ); // Displays an error icon if the image fails to load
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        itemLabels[index],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5), // Adjust the spacing as needed
                      Text(
                        itemDescriptions[index],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}