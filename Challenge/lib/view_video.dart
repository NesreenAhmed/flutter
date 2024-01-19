import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _auth = FirebaseAuth.instance;
final _fireStore = FirebaseFirestore.instance;

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  VideoPlayerWidget({required this.videoUrl});
  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  final String currentUserEmail = _auth.currentUser!.email.toString();
  final String currentUserId = _auth.currentUser!.uid;
  String _videoUrl = '';

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
      });

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  Future<void> _pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null) {
      File videoFile = File(result.files.single.path!);
      setState(()async {
        await uploadVideoToFirebaseStorage(videoFile);
      });
      print("Video URL: $_videoUrl");
    } else {
      // User canceled the file picker
    }

  }

  Future<String> uploadVideoToFirebaseStorage(File videoFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString(); // Unique file name
      Reference storageReference = FirebaseStorage.instance.ref().child('videos/$fileName.mp4');

      UploadTask uploadTask = storageReference.putFile(videoFile);
      await uploadTask;
      TaskSnapshot snapshot = await uploadTask;

      String videoUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        _videoUrl = videoUrl;
        if (_controller.value.isPlaying) {
          _controller.pause();
          _controller.play();
        }
      });
      await _fireStore
          .collection('postId').add({
        'sender': currentUserEmail,
        'id': currentUserId,
        'messageImage': videoUrl,
       // 'likes':likeCount,
        //'dislikes':dislikeCount,
        'timestamp': FieldValue.serverTimestamp(),
      });


      String downloadUrl = await storageReference.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading video: $e');
      return '';
    }
  }


  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    )
        : CircularProgressIndicator();

  }
}
