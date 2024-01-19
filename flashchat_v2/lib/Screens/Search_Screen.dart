import 'package:flutter/material.dart';
import 'package:flashchat_v2/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat_v2/Screens/chat_page.dart';
import 'package:flashchat_v2/components/drawer.dart';

final _auth = FirebaseAuth.instance;

class SearchScreen extends StatefulWidget {
  static String id = 'Search_Screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final String currentUserEmail = _auth.currentUser!.email.toString();
  final messageTextController = TextEditingController();
  String username = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(backgroundColor: kDarkBlueTwo,),
      backgroundColor: kDarkBlueTwo,
      body: Padding(
        padding: EdgeInsets.only(left: 22,),
        child: Column(
          children: [
            Text(
              'Search for your Happy Friends...',
              style: TextStyle(
                fontSize: 25,
                wordSpacing: 1,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'BilboSwashCaps',
              ),
            ),
            TextField(
              controller: messageTextController,
              style: TextStyle(color: Colors.white,fontSize: 18),
              onChanged: (value) {
                //Do something with the user input.
                setState(() {
                  username = value;
                });
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Search',

                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kLightBlueTwo, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kLightBlueTwo, width: 3.0),
                ),
                prefixIcon: Icon(Icons.search_rounded, color: kLightBlueTwo,),
                suffixIcon: IconButton(
                    onPressed: () {
                      messageTextController.clear();
                }, icon: Icon(Icons.clear_rounded, color: kLightBlueTwo,)
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('user').orderBy(
                    'username').startAt([username]).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('error');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('Loading..');
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index];
                        if (username.isEmpty) {
                          return ListTile(
                            title: Text(data['username'],style: TextStyle(color: Colors.white,fontSize: 20),),
                            subtitle: Text(data['email'],style: TextStyle(color: Colors.grey,fontSize: 16),),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChatPage(
                                            reciverUserEmail: data['email'],
                                            reciverUserId: data['uid'],
                                            userName: data['username'],)));
                            },
                          );
                        }
                        if (data['username'].toString().startsWith(
                            username.toLowerCase())) {
                          return ListTile(
                            onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChatPage(
                                          reciverUserEmail: data['email'],
                                          reciverUserId: data['uid'],
                                          userName: data['username'],)));
                          },

                            title: Text(data['username'],style: TextStyle(color: Colors.white,fontSize: 20),),
                            subtitle: Text(data['email'],style: TextStyle(color: Colors.grey,fontSize: 16),),


                          );
                        }
                      }

                  );
                }
            ),
            Flexible(child: Image.asset('images/search_image.png'))

          ],
        ),
      ),

    );
  }
}