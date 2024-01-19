import 'package:flashchat_v2/Screens/login_screen.dart';
import 'package:flashchat_v2/constants.dart';
import 'package:flutter/material.dart';
import 'package:flashchat_v2/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashchat_v2/Screens/chatroom.dart';
import 'package:transition/transition.dart';
import 'package:flashchat_v2/google_auth.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'Registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String email = '';
  String password = '';
  String username = '';
  String state = '';
  String bio='Empty bio';
  String userImage='';


  final messageTextController = TextEditingController();
  final messageTextController2 = TextEditingController();
  final messageTextController3 = TextEditingController();
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightBlueTwo,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
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
                      Opacity(
                        opacity: 0.8,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Image.asset(
                            'images/chat.png',
                            color: Colors.white,
                            scale: 9,
                          ),
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
                ],
              ),
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 190,
                    child: Image.asset(
                      'images/lightning_dark.png',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                  obscureText: false,
                  controller: messageTextController,
                  style: TextStyle(color: Colors.white,fontSize: 15),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    username = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your Username',
                      prefixIcon: Icon(
                        Icons.supervised_user_circle_rounded,
                        color: kDarkBlueTwo,
                        size: 25,
                      ),
                      suffixIcon: IconButton(
                          onPressed:(){
                            messageTextController.clear();
                          },
                          icon:Icon(Icons.close,
                            color: kDarkBlueTwo,)
                      ))),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: messageTextController2,
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
              messageTextController2.clear();
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
                  controller: messageTextController3,
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
                          messageTextController3.clear();
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
                            'username': username,
                            'state':state,
                            'bio':bio,
                            'userImage':userImage,
                          });
                          if(newUser.user!.emailVerified){
                            Navigator.pushNamed(context, HomePage.id);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async{
                      try{
                        //final UserCredential? authResult = await AuthService().signInWithGoogle();
                        final User? user = await AuthService().signInWithGoogle();
                        setState(() {
                          showSpinner = true;
                        });
                        if(user!=null){
                          String currentUserEmail = _auth.currentUser!.email.toString();
                          _firestore.collection('user').doc(user.uid).set({
                            'uid': user.uid,
                            'email': currentUserEmail,
                            'username': username,
                            'state':state,
                            'bio':bio,
                            'userImage':userImage,
                          });
                          Navigator.pushNamed(context, HomePage.id);
                        }
                        else{
                          print('Google Sign-In canceled by the user');
                        }
                        setState(() {
                          showSpinner = false;
                        });

                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Image.asset(
                      'images/google.png',
                      scale: 10,
                    ),
                  ),
                  SizedBox(width: 50),
                  Text(
                    'OR',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontFamily: 'Sevillana'),
                  ),
                  SizedBox(width: 50),
                  Image.asset(
                    'images/facebook.png',
                    scale: 10,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
