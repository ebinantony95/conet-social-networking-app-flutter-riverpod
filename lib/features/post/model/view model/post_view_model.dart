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
  Future<void> likePost(String postId, int currentLikes) async {
    await _firestore.collection('posts').doc(postId).update({
      'likesCount': currentLikes + 1,
    });
  }
}
