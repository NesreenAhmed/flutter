import 'package:flutter/material.dart';
import 'package:flashchat_v2/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashchat_v2/Screens/bio_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';

late User loggedInUser;
final _auth = FirebaseAuth.instance;
final _fireStore = FirebaseFirestore.instance;
final FirebaseStorage _storage =
    FirebaseStorage.instanceFor(bucket: 'gs://flashchat-v2-229ea.appspot.com');

class ChatPage extends StatefulWidget {
  static String id = 'Chat_page';
  final String reciverUserEmail;
  final String reciverUserId;
  final String userName;

  ChatPage(
      {required this.reciverUserEmail,
      required this.reciverUserId,
      required this.userName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final bool showIndicator = false;
  final messageTextController = TextEditingController();
  String messageText = '';
  File? _imageFile;
  String _imageUrl = '';
  final ImagePicker _picker = ImagePicker();
  final String currentUserId = _auth.currentUser!.uid;
  final String currentUserEmail = _auth.currentUser!.email.toString();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _pickImageGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    _cropImage(_imageFile!.path);
  }

  void _cropImage(String filepath) async {
    try {
      final ImageCropper imageCropper = ImageCropper();
      CroppedFile? croppedImage = await imageCropper.cropImage(
        sourcePath: filepath,
        maxHeight: 1080,
        maxWidth: 1080,
      );

      if (croppedImage != null) {
        setState(() {
          _imageFile = File(croppedImage.path);
          _uploadImage();
        });
      } else {
        print('Image cropping canceled.');
      }
    } catch (e) {
      print('Error cropping image: $e');
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) {
      print('No image selected.');
      return;
    }
    try {
      // Generate a unique file name for the image
      String fileName =
          'messageImage/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
      // Upload the image to Firebase Storage
      UploadTask uploadTask =
          _storage.ref().child(fileName).putFile(_imageFile!);
      TaskSnapshot snapshot = await uploadTask;
      // Get the download URL of the uploaded image
      List<String> ids = [currentUserEmail, widget.reciverUserEmail];
      ids.sort();
      String chatRoomId = ids.join('_');
      String imageUrl = await snapshot.ref.getDownloadURL();
      await _firestore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .add({
        'text': messageText,
        'sender': currentUserEmail,
        'id': currentUserId,
        'reciveremail': widget.reciverUserEmail,
        'messageImage': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      setState(() {
        _imageUrl = imageUrl;
      });

      print('Image uploaded successfully. URL: $_imageUrl');
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, actions: [
        StreamBuilder<DocumentSnapshot>(
            stream: _firestore
                .collection('user')
                .doc(widget.reciverUserId)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Text('error${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading..');
              }
              return Container(
                width: MediaQuery.of(context).size.width - 70,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(snapshot.data['userImage']),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data['username'],
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            snapshot.data['state'],
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BioScreen(
                                      reciverUserEmail: snapshot.data['email'],
                                      reciverUserId: snapshot.data['uid'],
                                      userName: snapshot.data['username'])));
                        },
                        child: null,
                      ),
                    )
                  ],
                ),
              );
            })
      ]),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/chatbackground.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            _buildMessageList(),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    List<String> ids = [currentUserEmail, widget.reciverUserEmail];
    ids.sort();
    String chatRoomId = ids.join('_');

    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore
            .collection('chat_rooms')
            .doc(chatRoomId)
            .collection('messages')
            .orderBy('timestamp', descending: false)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          if (snapshot.hasError) {
            return Text('error${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading..');
          }
          late final messages = snapshot.data.docs.reversed;

          List<Widget> messageBubbles = [];
          List<Widget> ImageBubbles = [];

          for (var message in messages) {
            final messageText = message.data()['text'];
            final messageSender = message.data()['sender'];
            final messageImage = message.data()['messageImage'];
            final currentUser = loggedInUser.email;
            if (messageText != null && messageText.isNotEmpty) {
              final messageBubble = MessageBubble(
                text: messageText,
                sender: messageSender,
                isMe: currentUser == messageSender,
              );
              messageBubbles.add(messageBubble);
            }

            if (messageImage != null && messageImage.isNotEmpty) {
              final imagemessage = ImageBubble(
                sender: messageSender,
                isMe: currentUser == messageSender,
                image: messageImage,
              );
              ImageBubbles.add(imagemessage);
            }
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: [
                ...messageBubbles,
                ...ImageBubbles,
              ],
            ),
          );
        });
  }

  Widget _buildMessageInput() {
    String upadateLastText = '';
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: messageTextController,
            onChanged: (value) {
              messageText = value;
            },
            decoration: kTextFieldDecoration.copyWith(
              hintText: 'message...',
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.image_outlined,
                  color: kDarkBlueTwo,
                  size: 30,
                ),
                onPressed: () {
                  _pickImageGallery();
                },
              ),
              hintStyle: TextStyle(color: Colors.grey.shade600),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kDarkBlueTwo),
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kDarkBlueTwo, width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
            ),
            obscureText: false,
          ),
        ),
        IconButton(
            onPressed: () async {
              messageTextController.clear();
              upadateLastText = messageText;
              //Implement send functionality.
              List<String> ids = [currentUserEmail, widget.reciverUserEmail];
              ids.sort();
              String chatRoomId = ids.join('_');
              await _fireStore
                  .collection('chat_rooms')
                  .doc(chatRoomId)
                  .collection('messages')
                  .add({
                'text': messageText,
                'sender': currentUserEmail,
                'id': currentUserId,
                'reciveremail': widget.reciverUserEmail,
                'messageImage': _imageUrl,
                'timestamp': FieldValue.serverTimestamp(),
              });
            },
            icon: Icon(
              Icons.send_rounded,
              size: 40,
              color: kDarkBlueTwo,
            ),
        ),

      ],
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({required this.text, required this.sender, required this.isMe});
  final String text;
  final String sender;
  final bool isMe;


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white54,
            ),
          ),
          Material(
            elevation: 5,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            borderRadius: isMe?BorderRadius.only(
                topLeft: Radius.circular(25),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)):
            BorderRadius.only(
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(30),
                bottomRight:Radius.circular(30)),
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Text(
                text,
                style: TextStyle(fontSize: 20,
                    color: isMe? Colors.white:Colors.black87),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class ImageBubble extends StatelessWidget {
  ImageBubble({required this.sender, required this.isMe, required this.image});
  final String sender;
  final String image;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white54,
            ),
          ),
          Material(
            elevation: 5,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
          ),
          Image.network(
            image,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
