import 'package:flutter/material.dart';
import 'package:flashchat_v2/Screens/welcome_screen.dart';
import 'package:flashchat_v2/Screens/login_screen.dart';
import 'package:flashchat_v2/Screens/resgistration_screen.dart';
import 'package:flashchat_v2/Screens/Start_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flashchat_v2/Screens/chatroom.dart';
import 'package:flashchat_v2/Screens/Search_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat_v2/Screens/profile_screen.dart';


final _auth = FirebaseAuth.instance;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBGbk5otzaDJdEQbZkR8SpH91B7QXc-2QA",
      appId: "1:431726189281:android:623e49cdddcf8f04b535a0",
      messagingSenderId: "431726189281",
      projectId: "flashchat-v2-229ea",
        storageBucket:'gs://flashchatv3-65222.appspot.com'
    ),

  );

  runApp(const FlashChat());

}

class FlashChat extends StatefulWidget {
  const FlashChat({super.key});

  @override
  State<FlashChat> createState() => _FlashChatState();
}

class _FlashChatState extends State<FlashChat> {
  @override

  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        print(user.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: _auth.currentUser!=null?HomePage.id: StartScreen.id,
      routes: {
        StartScreen.id:(context)=>StartScreen(),
        WelcomeScreen.id:(context)=>WelcomeScreen(),
        LoginScreen.id:(context)=>LoginScreen(),
        RegistrationScreen.id:(context)=>RegistrationScreen(),
        HomePage.id:(context)=>HomePage(),
        SearchScreen.id:(context)=>SearchScreen(),
        ProfileScreen.id:(context)=>ProfileScreen(),

      },
    );
  }
}



