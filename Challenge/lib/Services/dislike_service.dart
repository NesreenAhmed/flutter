import 'package:cloud_firestore/cloud_firestore.dart';

class DisLike {
  final String userId;
  final String postId;
  final bool isDisLiked;

  DisLike({
    required this.userId,
    required this.postId,
    required this.isDisLiked,
  });
}

class DisLikeService {
  final CollectionReference dislikesCollection = FirebaseFirestore.instance.collection('dislikes');

  Future<void> addDislike(DisLike dislike) async {
    await dislikesCollection.add({
      'userId': dislike.userId,
      'postId': dislike.postId,
      'isLiked': dislike.isDisLiked,
    });
  }

  Stream<List<DisLike>> getDisLikesForPost(String userId) {
    return dislikesCollection.where('userId', isEqualTo: userId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => DisLike(
        userId: doc['userId'],
        postId: doc['postId'],
        isDisLiked: doc['isLiked'],
      )).toList();
    });
  }


}