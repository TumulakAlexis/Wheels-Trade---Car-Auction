import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Screen3 extends StatefulWidget {
  const Screen3({super.key});

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('auction_items').get();
      final data = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      setState(() {
        _data = data;
      });
    } catch (e) {
      // Handle any errors here
      print('Error fetching data: $e');
    }
  }

  void _showBidDialog(BuildContext context, Map<String, dynamic> item) {
    final TextEditingController bidController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Place Bid for ${item['carBrand']} ${item['carModel']}'),
          content: TextField(
            controller: bidController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Enter your bid'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Place Bid'),
              onPressed: () {
                String bidAmount = bidController.text.trim();
                if (bidAmount.isNotEmpty) {
                  // Handle the bid submission logic here
                  // For example, you could save the bid amount to Firestore or perform any other action
                  print('Bid placed: $bidAmount');
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Auction Items.',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Color.fromARGB(255, 79, 99, 110),
          ),
        ),
      ),
      body: SafeArea(
        child: _data.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    childAspectRatio: 0.7, // Adjust as needed
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                  itemCount: _data.length,
                  itemBuilder: (context, index) {
                    final item = _data[index];
                    return GestureDetector(
                      onTap: () => _showBidDialog(context, item),
                      child: Card(
                        elevation: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            item['imageUrl'] != null
                                ? Image.network(
                                    item['imageUrl'],
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    height: 120,
                                    color: Colors.grey,
                                    child: const Center(
                                      child: Icon(
                                        Icons.image,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['carBrand'] ?? 'Unknown',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text('Model: ${item['carModel'] ?? 'Unknown'}'),
                                  const SizedBox(height: 4),
                                  Text('Price: \$${item['startingPrice'] ?? '0'}'),
                                  const SizedBox(height: 4),
                                  Text('Auctioneer: ${item['auctioneer'] ?? 'Unknown'}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
