import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:challenge/Services/comment_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:challenge/constants.dart';
import 'package:challenge/Services/like_service.dart';
import'package:challenge/Services/dislike_service.dart';
import 'package:chewie/chewie.dart';


late User loggedInUser;
final _auth = FirebaseAuth.instance;
final _fireStore = FirebaseFirestore.instance;

class Video_PlayScreen extends StatefulWidget {
  static String id = 'video_playscreen';

  @override
  State<Video_PlayScreen> createState() => _Video_PlayScreenState();
}

class _Video_PlayScreenState extends State<Video_PlayScreen> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  bool isLiked = false;
  bool iscommentLiked = false;
  bool isDisliked = false;
  String commentText='';
  int likeCount=0;
  int dislikeCount=0;

  final CommentService commentService = CommentService();
  final LikeService likeService = LikeService();
  final DisLikeService dislikeService = DisLikeService();
  final String currentUserEmail = _auth.currentUser!.email.toString();
  final String currentUserId = _auth.currentUser!.uid;
  Stream<List<Comment>> commentsStream = Stream.empty();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    //print(widget.videoAssetPath);
    _controller=VideoPlayerController.networkUrl(
        //Uri.parse(_videoUrl));
        Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'));
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: true,
    );
    //..initialize().then((_){
      //setState(() {});
    //})
    //..addListener(() {
    //if (_controller.value.hasError) {
    //print("Video Player Error: ${_controller.value.errorDescription}");
    //}
    //});
   _loadComments();

  }
  void _loadComments()  {
    commentsStream = commentService.getComments();
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

  @override
  void dispose(){
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  Future<void> _addComment(String commentText) async {
    Comment newComment = Comment(
      id: currentUserId, // You can use a unique identifier or use Firebase auto-generated ID
      text: commentText,
      userEmail: currentUserEmail, // Replace with the actual user ID
      timestamp: DateTime.now(),
    );
    await commentService.addComment(newComment);
    _loadComments();
  }

  void _showComments() {
    TextEditingController commentController = TextEditingController();
    showModalBottomSheet(
      constraints: BoxConstraints(
        maxHeight: 600,
      ),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.1,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            return Column(
              children: [
                FutureBuilder(
                  // Delay the StreamBuilder initialization
                  future: Future.delayed(Duration(milliseconds: 100), () => _loadComments()),
                  builder: (context, snapshot) {
                    return Expanded(
                      child: StreamBuilder<List<Comment>>(
                        stream: commentsStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Text('Loading..');
                          }
                          List<Comment> comments = snapshot.data ?? [];
                          comments = comments.reversed.toList();
                          return ListView.builder(
                            itemCount: comments.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                margin: EdgeInsets.all(10),
                                elevation: 2,
                                color: Colors.white54,
                                child: ListTile(
                                  title: Text(comments[index].text),
                                  subtitle: Text(comments[index].userEmail),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: commentController,
                        onChanged: (value) {
                          commentText = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Comment...',
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
                      icon: Icon(Icons.send),
                      onPressed: () {
                        String commentText = commentController.text;
                        if (commentText.isNotEmpty) {
                          _addComment(commentText);
                          commentController.clear();
                        }
                      },
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }




  void _likePost(String userId, bool isLiked) async {
      Like like = Like(userId: userId, postId: 'postId', isLiked: isLiked);
      await likeService.addLike(like);

  }
  void _dislikePost(String userId, bool isDisLiked) async {
    DisLike dislike = DisLike(userId: userId, postId: 'postId', isDisLiked: isDisLiked);
    await dislikeService.addDislike(dislike);
  }
  Future<void> unlikePost(String userId) async {
    try {
      await _fireStore.collection('likes').doc(userId).delete();
    } catch (e) {
      print('Error removing like: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    print("Controller Value: ${_controller.value}");

    return Scaffold(
      appBar: AppBar(
        title:Text ('Video player'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _controller.value.isInitialized
      ? AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      )
            : CircularProgressIndicator(),


          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    IconButton(
                        onPressed: (){
                          setState(() {
                            isLiked=!isLiked;
                            if(isDisliked){
                              isDisliked=false;
                            }
                          });
                           _likePost(currentUserEmail, isLiked);
                        },
                        icon: Icon(Icons.thumb_up_alt_outlined,color: isLiked?Colors.blue:Colors.grey
                        ),
                    ),
                    StreamBuilder<List<Like>>(
                      stream: likeService.getLikesForPost(currentUserEmail),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        List<Like> likes = snapshot.data ?? [];
                        likeCount = likes.where((like) => like.isLiked).length;

                        return Text(' $likeCount');
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),

                    IconButton(
                      onPressed: (){
                        setState(() {
                          isDisliked=!isDisliked;
                          if(isLiked){
                            isLiked=false;
                            unlikePost(currentUserEmail);
                          }
                        });
                        _dislikePost(currentUserEmail,isDisliked);
                      },
                      icon: Icon(Icons.thumb_down_alt_outlined,color: isDisliked?Colors.red:Colors.grey
                      ),
                    ),
                    StreamBuilder<List<DisLike>>(
                      stream: dislikeService.getDisLikesForPost(currentUserEmail),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        List<DisLike> dislikes = snapshot.data ?? [];
                        dislikeCount = dislikes.where((dislike) => dislike.isDisLiked).length;
                        return Text(' $dislikeCount');
                      },
                    ),
                    IconButton(
                      onPressed: (){
                        setState(() {
                          _showComments();
                        });
                      },
                      icon: Icon(Icons.mode_comment_outlined,color:Colors.grey
                      ),
                    ),

                    StreamBuilder<List<Comment>>(
                      stream: commentsStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        List<Comment> comments=snapshot.data??[];
                        int commentCount=comments.length;
                        return Text(' $commentCount');
                      },
                    ),
                    IconButton(
                      onPressed: ()async{
                       // await _pickVideo();
                      },
                      icon: Icon(Icons.upload_outlined,color:Colors.grey
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            _controller.value.isPlaying?_controller.pause():_controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying?Icons.pause:Icons.play_arrow,
        ),
      ),
    );
  }
}
