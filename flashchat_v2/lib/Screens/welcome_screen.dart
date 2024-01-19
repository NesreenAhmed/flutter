import 'package:flashchat_v2/constants.dart';
import 'package:flutter/material.dart';
import 'package:flashchat_v2/Screens/login_screen.dart';
import 'package:flashchat_v2/Screens/resgistration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flashchat_v2/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id='Welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
 late AnimationController controller;
 late Animation animation;

  void initState() {
    super.initState();
    controller=AnimationController(
        duration: Duration(seconds: 1),
        vsync: this,
    );
    animation=CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();
    controller.addListener(() {
      setState(() {

      });
      print(animation.value);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightBlueTwo.withOpacity(controller.value),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                AnimatedTextKit(
                   animatedTexts: [TypewriterAnimatedText('Welcome',textStyle:
                   const TextStyle(
                       fontFamily:'BilboSwashCaps',
                       fontSize: 60,
                       fontWeight: FontWeight.bold,
                       color: Colors.white
                   ),
                   ),
                   ],
                ),


              ],
            ),
           const SizedBox(
              height: 100,
            ),
            RoundedButton(color: kDarkBlueTwo,title: 'Create an Account',font: 'Roboto',onPress: (){
              Navigator.pushNamed(context, RegistrationScreen.id);
            },textColor: Colors.white),
          ],
        ),
      ),
    );
  }
}

