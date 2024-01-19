import 'package:flutter/material.dart';
import 'package:flashchat_v2/components/My_list.dart';
import 'package:flashchat_v2/constants.dart';
import 'package:flashchat_v2/Screens/Search_Screen.dart';
import 'package:flashchat_v2/Screens/Start_Screen.dart';
import 'package:flashchat_v2/Screens/profile_screen.dart';
import 'package:flashchat_v2/Screens/chatroom.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


final _auth = FirebaseAuth.instance;
final _fireStore = FirebaseFirestore.instance;
final FirebaseStorage _storage = FirebaseStorage.instanceFor(bucket: 'gs://flashchat-v2-229ea.appspot.com');
final FirebaseFirestore _firestore = FirebaseFirestore.instance;


class MyDrawer extends StatelessWidget {

  final String currentUserId = _auth.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 230,
      backgroundColor:kDarkBlueTwo ,
      child: Column(
        children: [
          StreamBuilder<DocumentSnapshot>(
              stream:_fireStore.collection('user').doc(currentUserId).snapshots(),
              builder: (context,AsyncSnapshot snapshot){
                if (snapshot.hasError) {
                  return Text('error${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading..');
                }
                return  DrawerHeader(
                  child:CircleAvatar(
                  radius: 50,

                  backgroundImage:NetworkImage(snapshot.data['userImage']),
                ),

                  //Icon(Icons.person,color: Colors.white, size: 64,),
                );
              }),

          MyListTile(icon: Icons.home, text: 'HOME',ontap: (){
            Navigator.pushNamed(context,  HomePage.id);
          },),
          MyListTile(icon: Icons.person, text: 'PROFILE', ontap:(){
            Navigator.pushNamed(context, ProfileScreen.id);

          }),
          MyListTile(icon: Icons.search_rounded, text: 'Search', ontap: (){
            Navigator.pushNamed(context, SearchScreen.id);
          }),
          SizedBox(
            height:400 ,
          ),

          MyListTile(icon: Icons.logout_outlined, text: 'LOGOUT', ontap: (){
            Navigator.pushNamed(context, StartScreen.id);
          })

        ],
      ),
    );
  }
}
