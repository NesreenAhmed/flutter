import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:challenge/constants.dart';
import 'package:challenge/components/rounded_button.dart';
import 'package:challenge/Screens/video_playscreen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'Login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String email = '';
  String password = '';
  String newValue = '';
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('Welcome Back',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 66,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'BilboSwashCaps'
                      ),
                    ),
                  ),
                ),

                TextField(
                  controller: emailTextController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white,fontSize: 15),
                  onChanged: (value) {
                    //Do something with the user input.
                    email= value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your Email',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kLightBlueTwo, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kLightBlueTwo, width: 3.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      prefixIcon: Icon(
                        Icons.supervised_user_circle_rounded,
                        color: kLightBlueTwo,
                        size: 25,
                      ),
                      suffixIcon: IconButton(
                          onPressed:(){
                            emailTextController.clear();
                          },
                          icon:Icon(Icons.close,
                            color: kLightBlueTwo,)
                      )
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                    controller: passwordTextController,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,fontSize: 15),
                    onChanged: (value) {
                      //Do something with the user input.
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: kLightBlueTwo, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: kLightBlueTwo, width: 3.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        prefixIcon: Icon(
                          Icons.key,
                          color: kLightBlueTwo,
                          size: 25,
                        ),
                        suffixIcon: IconButton(
                            onPressed:(){
                              passwordTextController.clear();
                            },
                            icon:Icon(Icons.close,
                              color: kLightBlueTwo,)
                        ))
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 195.0),
                  child: TextButton(
                      onPressed: ()async{
                        try{
                          showDialog(
                              context: context,
                              builder: (context){
                                return AlertDialog(
                                  title: Text('Password Reset Email Sent'),
                                  content: TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    autofocus: true,
                                    style: TextStyle(color: Colors.black87),
                                    decoration: InputDecoration(
                                      hintText: 'Enter Your Email',
                                      hintStyle: TextStyle(color: Colors.grey.shade700),
                                    ),
                                    onChanged: (value)  {
                                      newValue = value;
                                    },
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: ()async {
                                        Navigator.of(context).pop();
                                        if (newValue != null && newValue.isNotEmpty){
                                          await FirebaseAuth.instance.sendPasswordResetEmail(email: newValue);
                                        }
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              }
                          );

                        }catch(e){
                          print(e);
                        }
                      },
                      child: Text('Forget your password?',style: TextStyle(color: Colors.grey),)
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Flexible(
                  child: RoundedButton(
                      color: kLightBlueTwo,
                      title: 'Log In',
                      font: 'Roboto',
                      onPress: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          final user=await _auth.signInWithEmailAndPassword(email: email, password: password);
                          if(user!=null){
                            Navigator.pushNamed(context, Video_PlayScreen.id);
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          print(e);
                        }
                      },
                      textColor: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
