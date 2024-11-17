import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../Bloc/PostBloc.dart';
import '../../Bloc/PostEvent.dart';
import '../../Bloc/PostState.dart';

class PostListPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final postBloc = context.read<PostBloc>();

    useEffect(() {
      postBloc.add(const FetchPosts(page: 1));
      return null;
    }, []);

    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent * 0.9) {
        final currentState = postBloc.state;
        if (currentState is Success && !currentState.hasReachedMax) {
          final nextPage = (currentState.posts.length ~/ 10) + 1; ///10/10+1 and so on
          postBloc.add(FetchPosts(page: nextPage));
        }
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (posts, hasReachedMax) {
              return ListView.builder(
                controller: scrollController,
                itemCount: hasReachedMax ? posts.length : posts.length + 1,
                itemBuilder: (context, index) {
                  if (index >= posts.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final post = posts[index];
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.body),
                  );
                },
              );
            },
            failure: () => const Center(child: Text('Failed to fetch posts.')),
          );
        },
      ),
    );
  }
}
