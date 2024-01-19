import 'package:flashchat_v2/constants.dart';
import 'package:flutter/material.dart';
import 'package:flashchat_v2/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashchat_v2/Screens/chatroom.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'Login_screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String email = '';
  String password = '';
  String username = '';
  String state = '';
  String bio='Empty bio';
  String userImage='';
  bool showSpinner = false;
  String newValue = '';
  final messageTextController = TextEditingController();
  final messageTextController2 = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBlueTwo,
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

                Expanded(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset(
                        'images/lightning_dark.png',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                TextField(
                  controller: messageTextController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white,fontSize: 15),
                  onChanged: (value) {
                    //Do something with the user input.
                    username = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your Username',
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
                            messageTextController.clear();
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
                  controller: messageTextController2,
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
                              messageTextController2.clear();
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
                          QuerySnapshot snap = await _firestore
                              .collection('user')
                              .where('username', isEqualTo: username)
                              .get();
                  
                          email = snap.docs[0]['email']!.toString();
                          bio=snap.docs[0]['bio']!.toString();
                          userImage=snap.docs[0]['userImage']!.toString();
                          final user = await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          _firestore.collection('user').doc(user.user!.uid).set({
                            'uid': user.user!.uid,
                            'email': email,
                            'username': username,
                            'state':state,
                            'bio':bio,
                            'userImage':userImage,
                          });
                  
                  
                          if (user != null) {
                            Navigator.pushNamed(context, HomePage.id);
                            //Navigator.push(
                                //context,
                                //MaterialPageRoute(
                                    //builder: (context)=>HomePage(userName: username,)));
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
