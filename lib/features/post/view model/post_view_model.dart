import 'package:conet_app/features/post/model/post_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/legacy.dart';

final postViewModelProvider =
    StateNotifierProvider<PostViewModel, AsyncValue<List<PostModel>>>(
      (ref) => PostViewModel(),
    );

class PostViewModel extends StateNotifier<AsyncValue<List<PostModel>>> {
  PostViewModel() : super(const AsyncLoading()) {
    fetchPosts();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// 🔹 FETCH POSTS (Realtime)
  void fetchPosts() {
    _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
          final posts = snapshot.docs
              .map((doc) => PostModel.fromMap(doc.data(), doc.id))
              .toList();

          state = AsyncData(posts);
        });
  }

  /// 🔹 CREATE POST
  Future<void> createPost({
    required String userId,
    required String userName,
    required String userAvatar,
    required String content,
  }) async {
    try {
      await _firestore.collection('posts').add({
        'userId': userId,
        'userName': userName,
        'userAvatar': userAvatar,
        'content': content,
        'createdAt': Timestamp.now(),
        'likesCount': 0,
      });
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  /// 🔹 LIKE POST
  Future<void> likePost(String postId) async {
    final ref = _firestore.collection('posts').doc(postId);

    await _firestore.runTransaction((transaction) async {
      final snap = await transaction.get(ref);
      final currentLikes = snap['likesCount'] ?? 0;

      transaction.update(ref, {'likesCount': currentLikes + 1});
    });
  }

  /// 🔹 GET USER POSTS (REALTIME)
  Stream<List<PostModel>> getUserPosts(String userId) {
    return _firestore
        .collection('posts')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => PostModel.fromMap(doc.data(), doc.id))
              .toList();
        });
  }

  /// 🔹 DELETE POST (optional but useful)
  Future<void> deletePost(String postId) async {
    await _firestore.collection('posts').doc(postId).delete();
  }
}
