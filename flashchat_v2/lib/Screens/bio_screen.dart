import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashchat_v2/constants.dart';
import 'package:flutter/material.dart';
import 'package:flashchat_v2/components/textbox.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flashchat_v2/components/rounded_button.dart';
import 'package:flashchat_v2/Screens/resgistration_screen.dart';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class BioScreen extends StatefulWidget {
  static String id='Bio_screen';
  final String reciverUserEmail;
  final String reciverUserId;
  final String userName;
  BioScreen({required this.reciverUserEmail,required this.reciverUserId,required this.userName});

  @override
  State<BioScreen> createState() => _BioScreenState();
}

class _BioScreenState extends State<BioScreen> with SingleTickerProviderStateMixin {
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
      appBar: AppBar(
        backgroundColor: kDarkBlueTwo,
      ),
      backgroundColor: kDarkBlueTwo.withOpacity(controller.value),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                StreamBuilder<DocumentSnapshot>(
                 stream: _firestore.collection('user').doc(widget.reciverUserId).snapshots(),
                 builder: (context,AsyncSnapshot snapshot){
                   if(snapshot.hasError){
                     return Text('error');
                   }
                   if(snapshot.connectionState==ConnectionState.waiting){
                     return Text('Loading..');
                   }
                    return Container(
                      width: MediaQuery.of(context).size.width-70,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          CircleAvatar(
                            radius: 80,
                            backgroundImage:NetworkImage(snapshot.data['userImage']),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 25),
                            child: Text(
                              'User Details',
                              style: TextStyle(color: Colors.grey.shade500),
                            ),
                          ),
                          MyTextBox(
                            text: snapshot.data['username'],
                            sectionName: 'username',
                            onpressed: (){},
                          ),
                          MyTextBox(
                            text: snapshot.data['email'],
                            sectionName: 'Email',
                            onpressed: () {},
                          ),
                          MyTextBox(text: snapshot.data['bio'], sectionName: 'bio', onpressed: () {})
                        ],
                      ),
                    );
        },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
