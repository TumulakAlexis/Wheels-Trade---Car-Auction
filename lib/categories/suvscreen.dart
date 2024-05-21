import 'package:flutter/material.dart';

class Suv extends StatefulWidget {
  const Suv({super.key});

  @override
  State<Suv> createState() => _SuvState();
}

class _SuvState extends State<Suv> {
   final List<String> suvAuctionImages = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8Z53aF9oUTmv_WKFzs_2vgDS25Po5Ml2iQ6hX9iyXmA&s',  // Replace with actual image URLs
    'https://cdn.motor1.com/images/mgl/PKZQL/s3/1997-toyota-supra-sold-for-176-000-at-auction.jpg',
    'https://files.porsche.com/filestore/image/multimedia/none/992-c4cab-gts-modelexplorer/normal/61b8c9bc-d2a7-11eb-80d9-005056bbdc38;sS;twebp/porsche-normal.webp',
  ];

  List<String> itemLabels = [
    'Nissan GT-R',
    'Toyota Supra MK4',
    'Porsche 911 Carrera',
  ];

  List<String> itemDescriptions = [
    'Starting Bid: P3,000,000',
    'Starting Bid: P1,000,000',
    'Starting Bid: P6,000,000',
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
