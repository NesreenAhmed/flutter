import 'package:challenge/Screens/Login_screen.dart';
import 'package:flutter/material.dart';
import 'package:challenge/Screens/video_playscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:challenge/Screens/signin_screen.dart';
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: FirebaseOptions(
        apiKey: "AIzaSyDXJ6KziatGPeUZsK2cKxfeANOl8tlIlf4",
        appId: "1:156121057739:android:7ce022a31f21e21bd08e4e",
        messagingSenderId: "156121057739",
        projectId: "challenge-8616e",
        storageBucket:'gs://challenge-8616e.appspot.com'
    ),

  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        SignIn_Screen.id:(context)=>SignIn_Screen(),
        LoginScreen.id:(context)=>LoginScreen(),
        Video_PlayScreen.id:(context)=>Video_PlayScreen(),
      },

      home: Scaffold(
        appBar: AppBar(
          title: Text('Video'),
          centerTitle: true,
        ),

        body: Center(
          child: Builder(
            builder:(context)=> ElevatedButton(
              onPressed: () {
               Navigator.pushNamed(context, SignIn_Screen.id);

              },
              child: Text('play video'),
            ),
          ),
        ),
      ),
    );
  }
}
//Navigator.push(
//context,
//MaterialPageRoute(
//builder: (context) {
//return Video_PlayScreen(videoAssetPath: 'videos/pexels-alessandro-polese-19490698 (Original).mp4');
//},
//),
//);