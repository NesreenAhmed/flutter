import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String id;
  final String text;
  final String userEmail;
  final DateTime timestamp;


  Comment({required this.id, required this.text, required this.userEmail, required this.timestamp,});
}


class CommentService {
  final CollectionReference commentsCollection = FirebaseFirestore.instance.collection('comments');
  Future<void> addComment(Comment comment) async {
    await commentsCollection.add({
      'text': comment.text,
      'userId': comment.userEmail,
      'timestamp': comment.timestamp,
    });
  }

  Stream<List<Comment>> getComments() {
    return commentsCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Comment(
      id: doc.id,
      text: doc['text'],
      userEmail: doc['userId'],
      timestamp: (doc['timestamp'] as Timestamp).toDate(),
    )).toList());
  }
}