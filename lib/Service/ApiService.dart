import 'dart:async';

import '../Model/Model.dart';

class PostRepository {
  Future<List<Post>> fetchPosts(int page, int limit) async {
    await Future.delayed(const Duration(seconds: 2));
    return List.generate(
      limit,
          (index) => Post(
        id: (page - 1) * limit + index + 1,
        title: 'Post Title ${(page - 1) * limit + index + 1}',
        body: 'This is the body of the post ${(page - 1) * limit + index + 1}.',
      ),
    );
  }
}
