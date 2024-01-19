import 'package:flashchat_v2/constants.dart';
import'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat_v2/Screens/chat_page.dart';
import 'package:intl/intl.dart';
import 'package:flashchat_v2/components/drawer.dart';

final _auth = FirebaseAuth.instance;

class HomePage extends StatefulWidget {
  static String id = 'Home_Page';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final String currentUserEmail = _auth.currentUser!.email.toString();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override

  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    setStatus("onlne");
  }

  void setStatus(String status) async {
    await _firestore.collection('user').doc(_auth.currentUser!.uid).update({
      "state": status,
      //'lastseen'
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
    } else {
      // offline
      DateTime now = DateTime.now();
      String formattedDate='';
      formattedDate = DateFormat('EE | hh:mm a').format(now);
      //print(now.hour.toString() + ":" + now.minute.toString() + ":" + now.second.toString());
      setStatus(formattedDate);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kDarkBlueTwo,
     drawer:MyDrawer() ,
      appBar: AppBar(
        title: Text('Home Page',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.transparent,

      ),
      body: Container(


          child: _buildUserList()),

    );
  }

  Widget _buildUserList(){
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('user').snapshots(),
        builder: (context,AsyncSnapshot snapshot){
          if(snapshot.hasError){
            return Text('error');
          }
          if(snapshot.connectionState==ConnectionState.waiting){
            return Text('Loading..');
          }
          return ListView(
            children: snapshot.data!.docs.map<Widget>((doc)=>_buildUserListIteam(doc) ).toList(),
          );
        }
    );
  }

  Widget _buildUserListIteam(DocumentSnapshot document){
    Map<String,dynamic>data=document.data()!as Map<String,dynamic>;
    String lastText='';
    if(_auth.currentUser!.email!=data['email']){
      return Card(
        margin: EdgeInsets.all(10),
        elevation: 5,
        color: kLightBlueTwo,
        //Color(0xFF274d8b),
        child: ListTile(
          title:Text(data['username'],style: TextStyle(fontSize: 23,color: Colors.white),),
          leading:  CircleAvatar(
            radius: 20,
            backgroundImage:NetworkImage(data['userImage']),
          ),
          subtitle: Text('$lastText..', style: TextStyle(fontSize: 23,color: Colors.black54)),
          onTap:()async{
           lastText =await Navigator.push(
                context,
                  MaterialPageRoute(
                      builder: (context)=>ChatPage(reciverUserEmail: data['email'],reciverUserId: data['uid'],userName:data['username'])));
            setState(() {
              print(lastText);
            });
          },
            ),
      );
    }
     else{
      return Container();
    }
  }

  Widget _buildLastMessageList(){
    //List<String> ids = [currentUserEmail, reciverUserEmail];
    //ids.sort();
   // String chatRoomId = ids.join('_');
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('chat_rooms').doc('chatRoomId').collection('messages').orderBy('timestamp', descending: false).snapshots(),
        builder: (context,snapshot){

          if(snapshot.hasError){

            return Text('error');
          }
          if(snapshot.connectionState==ConnectionState.waiting){
            return Text('Loading..');
          }
          return ListView(
            children: snapshot.data!.docs.map<Widget>((doc)=>_buildLastMessageListIteam(doc) ).toList(),
          );
        }
    );
  }

  Widget _buildLastMessageListIteam(DocumentSnapshot document){
    Map<String,dynamic>data=document.data()!as Map<String,dynamic>;
    if(_auth.currentUser!.email!=data['email']){
      return ListTile(
          title:Text(data['username'],style: TextStyle(fontSize: 23),),
          subtitle: Text(data['text']),
      );
    }
    else{
      return Container();
    }
  }
}
