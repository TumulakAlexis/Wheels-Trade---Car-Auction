import 'package:flutter/material.dart';

class Sedan extends StatefulWidget {
  const Sedan({super.key});

  @override
  State<Sedan> createState() => _SedanState();
}

class _SedanState extends State<Sedan> {
  final List<String> suvAuctionImages = [
    'https://upload.wikimedia.org/wikipedia/commons/f/fe/2022_Toyota_Yaris_ATIV_1.2_Premium_Luxury_%282%29.jpg',  // Replace with actual image URLs
    'https://images.topgear.com.ph/topgear/images/2023/07/13/nissan-almera-2023-main-1689252583.jpg',
    'https://images.topgear.com.ph/topgear/images/2023/09/11/1-1694428290.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRONvDM8kpg9s_8l1zNYsitPW0h29wMJ0yLmqQ-b0eEmw&s'

  ];

  List<String> itemLabels = [
    'Toyota Vios 2023',
    'Nissan Almera 2024',
    'Honda City 2023',
    'Honda Civic 2023'
  ];

  List<String> itemDescriptions = [
    'Starting Bid: P500,000',
    'Starting Bid: P1,000,000',
    'Starting Bid: P700,000',
    'Starting Bid: P900,000'
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