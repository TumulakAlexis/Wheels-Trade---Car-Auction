import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:wheels_trade/screens/home%20screens/categories/pickupscreen.dart';
import 'package:wheels_trade/screens/home%20screens/categories/sedanscreen.dart';
import 'package:wheels_trade/screens/home%20screens/categories/sportsscreen.dart';
import 'package:wheels_trade/screens/home%20screens/categories/suvscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wheels_trade/screens/onboardingpage1.dart';


class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<User?> _getUserData() async {
  User? user = _auth.currentUser;

  if (user == null) {
    // If user is not signed in, sign in with Google
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      user = userCredential.user;
    }
  }

  return user;
}



  final List<String> imgList = [
    'https://content.toyota.com.ph/uploads/vehicle_features/168/005_168_1694584761801_000.webp',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3EdJ-kWMwLX4oge5K9dWoQRt0mqM8LrjnBt1FSyH6Zg&s',
    'https://www.shutterstock.com/image-photo/surabaya-indonesia-february-2-2023-260nw-2257212653.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTE61tVHxRqvTpQMvUmKFn6vN7B56bBBggcuI8Rc8ezA&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXqIM-245BGV7fYdQIAYXX3O-8UDg8B_TJMlJn8B0iSg&s',
  ];

  final List<String> categories = [
    'Suv',
    'Sedan',
    'Sports',
    'Pickup',
  ];

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Wheels Trade",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 79, 99, 110),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 79, 99, 110),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to the home screen or any other screen
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to the profile screen or any other screen
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to the settings screen or any other screen
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sign Out'),
              onTap: () async {
                await _signOut;
                Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnboardingPage1()));
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Explore.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Color.fromARGB(255, 79, 99, 110),
                ),
              ),
              const SizedBox(height: 20),
              CarouselSlider(
                options: CarouselOptions(
                  height: 350.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
                items: imgList.map((item) => Container(
                  margin: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(item),
                      fit: BoxFit.cover,
                    ),
                  ),
                )).toList(),
              ),
              const SizedBox(height: 50),
              const Text(
                "Categories.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Color.fromARGB(255, 79, 99, 110),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 400, // Adjust this height as needed
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        if (categories[index] == 'Suv') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Suv()),
                          );
                        } else if (categories[index] == 'Sedan') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Sedan()),
                          );
                        } else if (categories[index] == 'Sports') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Sports()),
                          );
                        } else if (categories[index] == 'Pickup') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Pickup()),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.blueGrey,
                        ),
                        child: Center(
                          child: Text(
                            categories[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _signOut() async {
    await _googleSignIn.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingPage1()));
  }
}

