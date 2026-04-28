import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/models/post_model.dart';

class PostCubit extends Cubit<List<Post>> {
  PostCubit() : super([]);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void loadPosts() {
    _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      final posts = snapshot.docs
          .map((doc) => Post.fromMap(doc.data(), doc.id))
          .toList();

      emit(posts);
    });
  }

  Future<void> createPost(String content, String username) async {
    if (content.isEmpty) return;

    await _firestore.collection('posts').add({
      'content': content,
      'username': username,
      'likes': 0,
      'likedBy': [],
      'createdAt': Timestamp.now(),
    });
  }

  Future<void> toggleLike(String postId, List likedBy) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final doc = _firestore.collection('posts').doc(postId);

    if (likedBy.contains(userId)) {
      await doc.update({
        'likedBy': FieldValue.arrayRemove([userId]),
        'likes': FieldValue.increment(-1),
      });
    } else {
      await doc.update({
        'likedBy': FieldValue.arrayUnion([userId]),
        'likes': FieldValue.increment(1),
      });
    }
  }
}