import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wheels_trade/screens/homescreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OnboardingPage1 extends StatefulWidget {
  const OnboardingPage1({super.key});

  @override
  State<OnboardingPage1> createState() => _SignUpState();
}

class _SignUpState extends State<OnboardingPage1> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _signInWithGoogle() async {
    try {
      print("Starting Google Sign-In");
      
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        print("Google Sign-In was aborted by the user");
        return;
      }

      print("Google Sign-In account retrieved: ${googleSignInAccount.displayName}");

      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      print("Google authentication retrieved: accessToken=${googleSignInAuthentication.accessToken}, idToken=${googleSignInAuthentication.idToken}");

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      print("Credential created");

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        print("User signed in successfully: ${user.displayName}");
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePageNav()));
      } else {
        print("User is null after sign-in");
      }
    } catch (error) {
      print("Error during Google Sign-In: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 238, 188),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              child: Image.asset('assets/wheellogo.png'),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageNav()));
              },
              child: Container(
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 79, 99, 110),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Center(child: Text("Sign in Anonymously", style: TextStyle(color: Color.fromARGB(255, 240, 235, 235), fontSize: 15, fontWeight: FontWeight.bold),)),
              ),
            ),
            SizedBox(height: 25,),
            GestureDetector(
              onTap: _signInWithGoogle,
              child: Container(
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 238, 188), 
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color.fromARGB(255, 79, 99, 110))
                ),
                child: Row(
                  children: [
                    SizedBox(width: 30,),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset('assets/googlelogo.png')),
                    Center(
                      child: Text("    Sign in with Google", style: TextStyle(color: Color.fromARGB(255, 79, 99, 110), fontSize: 15, fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
