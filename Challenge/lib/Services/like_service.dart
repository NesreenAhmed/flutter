import 'package:cloud_firestore/cloud_firestore.dart';


final _fireStore = FirebaseFirestore.instance;

class Like {
  final String userId;
  final String postId;
  final bool isLiked;

  Like({
    required this.userId,
    required this.postId,
    required this.isLiked,
  });
}

class LikeService {
  final CollectionReference likesCollection = FirebaseFirestore.instance.collection('likes');

  Future<void> addLike(Like like) async {
    await likesCollection.add({
      'userId': like.userId,
      'postId': like.postId,
      'isLiked': like.isLiked,
    });
  }


  Stream<List<Like>> getLikesForPost(String userId) {
    return likesCollection.where('userId', isEqualTo: userId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Like(
        userId: doc['userId'],
        postId: doc['postId'],
        isLiked: doc['isLiked'],
      ))
          .toList();
    });
  }
}

