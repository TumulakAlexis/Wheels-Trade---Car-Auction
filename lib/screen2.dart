import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:file_picker/file_picker.dart';

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  final TextEditingController _auctioneerController = TextEditingController();
  final TextEditingController _carBrandController = TextEditingController();
  final TextEditingController _carModelController = TextEditingController();
  final TextEditingController _startingPriceController = TextEditingController();
  File? _imageFile;

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      setState(() {
        _imageFile = File(result.files.single.path!);
      });
    }
  }

  void _addAuctionItemToFirestore() async {
    // Get values from text controllers
    String auctioneer = _auctioneerController.text.trim();
    String carBrand = _carBrandController.text.trim();
    String carModel = _carModelController.text.trim();
    String startingPrice = _startingPriceController.text.trim();

    // Upload image to Firebase Storage
    String? imageUrl;
    if (_imageFile != null) {
      try {
        // Create a reference to the location you want to upload to in Firebase Storage
        firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('auction_item_images')
            .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

        // Upload file to Firebase Storage
        await ref.putFile(_imageFile!);

        // Get the download URL for the image
        imageUrl = await ref.getDownloadURL();
      } catch (e) {
        print('Error uploading image: $e');
      }
    }

    // Add data to Firestore
    FirebaseFirestore.instance.collection('auction_items').add({
      'auctioneer': auctioneer,
      'carBrand': carBrand,
      'carModel': carModel,
      'startingPrice': startingPrice,
      'imageUrl': imageUrl, // Add image URL to Firestore
    });

    // Clear text fields after adding data
    _auctioneerController.clear();
    _carBrandController.clear();
    _carModelController.clear();
    _startingPriceController.clear();
    setState(() {
      _imageFile = null; // Clear image file
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 50, 30, 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Add Auction Item",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color.fromARGB(255, 79, 99, 110),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 280,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 79, 99, 110),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: _imageFile != null
                      ? Image.file(_imageFile!, fit: BoxFit.cover)
                      : Icon(Icons.add_a_photo, size: 50, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _auctioneerController,
                decoration: InputDecoration(
                  hintText: 'Input Name of Auctioneer',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _carBrandController,
                decoration: InputDecoration(
                  hintText: 'Input Car Brand',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _carModelController,
                decoration: InputDecoration(
                  hintText: 'Input Car Model',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _startingPriceController,
                decoration: InputDecoration(
                  hintText: 'Input Starting Price',
                ),
              ),
              SizedBox(height: 20), // Add extra space at the bottom
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAuctionItemToFirestore,
        backgroundColor: Color.fromARGB(255, 79, 99, 110),
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  @override
  void dispose() {
    // Clean up controllers
    _auctioneerController.dispose();
    _carBrandController.dispose();
    _carModelController.dispose();
    _startingPriceController.dispose();
    super.dispose();
  }
}
