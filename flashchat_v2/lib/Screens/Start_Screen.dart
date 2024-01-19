import 'package:flashchat_v2/constants.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flashchat_v2/components/rounded_button.dart';
import 'package:flashchat_v2/Screens/resgistration_screen.dart';

class StartScreen extends StatefulWidget {
  static String id='Start_screen';

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> with SingleTickerProviderStateMixin {
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
      backgroundColor: kDarkBlueTwo.withOpacity(controller.value),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/lightning_new.png'),
                    height: animation.value*100,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [TypewriterAnimatedText('Flash Chat',textStyle:
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
              height: 50,
            ),
           Text('Unlock the door to endless conversations; welcome to the world of Flash Chat',
             style: TextStyle(
             fontSize: 25,
               fontWeight: FontWeight.bold,
               color: Colors.white,
               fontFamily: 'Caveat',

           ),
           ),

            Image.asset('images/start_image22.png'),
            SizedBox(
              height:50 ,
            ),
            RoundedButton(color: kLightBlueTwo,title: 'Let\'s Start...',font: 'BebasNeue',
                  onPress: (){
                  Navigator.pushNamed(context, RegistrationScreen.id);
                               },
                  textColor: Colors.white,
                               ),

          ],
        ),
      ),
    );
  }
}

