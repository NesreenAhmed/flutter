import 'package:challenge/Screens/video_playscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transition/transition.dart';
import 'package:challenge/constants.dart';
import 'package:challenge/components/rounded_button.dart';
import 'package:challenge/Screens/Login_screen.dart';

class SignIn_Screen extends StatefulWidget {
  static String id = 'SignIn_screen';

  @override
  State<SignIn_Screen> createState() => _SignIn_ScreenState();
}

class _SignIn_ScreenState extends State<SignIn_Screen> {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String email = '';
  String password = '';
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontFamily: 'BilboSwashCaps',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 70,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 90, top: 85.0),
                child: Text(
                  'Create an Account',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blueGrey.shade400,
                  ),
                ),
              ),

              TextField(
                  controller: emailTextController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white,fontSize: 15),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email',
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: kDarkBlueTwo,
                        size: 25,
                      ),
                      suffixIcon: IconButton(
                          onPressed:(){
                            emailTextController.clear();
                          },
                          icon:Icon(Icons.close,
                            color: kDarkBlueTwo,)
                      )
                  )
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                  controller: passwordTextController,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,fontSize: 15),
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password',
                      prefixIcon: Icon(
                        Icons.key,
                        color: kDarkBlueTwo,
                        size: 25,
                      ),
                      suffixIcon: IconButton(
                          onPressed:(){
                            passwordTextController.clear();
                          },
                          icon:Icon(Icons.close,
                            color: kDarkBlueTwo,)
                      )
                  )
              ),
              const SizedBox(
                height: 20.0,
              ),
              Flexible(
                child: RoundedButton(
                    color: kDarkBlueTwo,
                    title: 'Sign Up',
                    font: 'Roboto',
                    onPress: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final newUser =
                        await _auth.createUserWithEmailAndPassword(
                            email: email, password: password);

                        if(newUser!=null){
                          // Send email verification
                          await newUser.user!.sendEmailVerification();
                          _firestore.collection('user').doc(newUser.user!.uid).set({
                            'uid': newUser.user!.uid,
                            'email': email,
                          });
                          if(newUser.user!.emailVerified){
                            Navigator.pushNamed(context, Video_PlayScreen.id);
                          }
                          else{
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Verification Email Sent'),
                                  content: Text(
                                    'A verification email has been sent to $email. '
                                        'Please check your email and verify your account.',
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }

                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    textColor: Colors.white
                ),
              ),
              Center(
                child: GestureDetector(
                    child: Text(
                      'have an account',
                      style: TextStyle(color: Colors.blueGrey.shade200),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          Transition(
                              child: LoginScreen(),
                              transitionEffect:
                              TransitionEffect.BOTTOM_TO_TOP));
                    }),
              ),
              SizedBox(
                height: 60,
                child: Divider(
                  color: Colors.grey.shade200,
                  indent: 50,
                  endIndent: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
