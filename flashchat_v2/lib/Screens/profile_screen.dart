import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat_v2/constants.dart';
import 'package:flashchat_v2/components/textbox.dart';
import 'package:flashchat_v2/components/drawer.dart';
import 'package:image_cropper/image_cropper.dart';

final _auth = FirebaseAuth.instance;
final _fireStore = FirebaseFirestore.instance;
final FirebaseStorage _storage = FirebaseStorage.instanceFor(bucket: 'gs://flashchat-v2-229ea.appspot.com');
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ProfileScreen extends StatefulWidget {
  static String id = 'profile_Screen';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imageFile;
  String _imageUrl='';
  final ImagePicker _picker=ImagePicker();
  final String currentUserEmail = _auth.currentUser!.email.toString();
  final String currentUserId = _auth.currentUser!.uid;
  final userCollection = _fireStore.collection('user');

  Future<void> editField(String field) async {
    String newValue = '';
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.grey.shade500,
          title: Text(
            'Edit $field',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            autofocus: true,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Enter new $field',
              hintStyle: TextStyle(color: Colors.grey.shade700),
            ),
            onChanged: (value) {
              newValue = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(newValue),
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ));
    if (newValue.trim().length > 0) {
      await userCollection.doc(currentUserId).update({field: newValue});
    }
  }

  Future<void> _pickImageCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    _cropImage(_imageFile!.path);
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
      String fileName = 'userImage/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
      // Upload the image to Firebase Storage
      UploadTask uploadTask = _storage.ref().child(fileName).putFile(_imageFile!);
      TaskSnapshot snapshot = await uploadTask;
      // Get the download URL of the uploaded image
      String imageUrl = await snapshot.ref.getDownloadURL();
      await _firestore.collection('user').doc(currentUserId).update({
        'userImage': imageUrl,
      });
      setState(() {
        _imageUrl = imageUrl;
      });

      print('Image uploaded successfully. URL: $_imageUrl');
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBlueTwo,
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kDarkBlueTwo,
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _fireStore.collection('user').doc(currentUserId).snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text('error${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading..');
          }
          //final userData = snapshot.data!.data() as Map<String, dynamic>;
          return ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 50,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage:NetworkImage(snapshot.data['userImage']),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 95.0,top: 130),
                    child: IconButton(icon:Icon(Icons.image_outlined,size: 35,color: Colors.white,),
                        onPressed: ()async{
                          _pickImageGallery();
                          //_uploadImage();
                        }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 95.0,top: 130),
                    child: IconButton(icon:Icon(Icons.camera_alt_outlined,size: 35,color: Colors.white,),
                        onPressed: ()async{
                          _pickImageCamera();
                          //_uploadImage();
                        }
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                currentUserEmail,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade500),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  'MY Details',
                  style: TextStyle(color: Colors.grey.shade500),
                ),
              ),
              MyTextBox(
                text: snapshot.data['username'],
                sectionName: 'username',
                onpressed: () => editField('username'),
              ),
              MyTextBox(
                text: snapshot.data['email'],
                sectionName: 'Email',
                onpressed: () => editField('email'),
              ),
              MyTextBox(text: snapshot.data['bio'], sectionName: 'bio', onpressed: () => editField('bio'),)
            ],
          );
        },
      ),
    );
  }
}


