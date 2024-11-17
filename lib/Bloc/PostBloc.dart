import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_flutter_bloc_freezed/Bloc/PostEvent.dart';
import 'package:pagination_flutter_bloc_freezed/Bloc/PostState.dart';
import 'package:pagination_flutter_bloc_freezed/Service/ApiService.dart';

class PostBloc extends Bloc<PostEvent,PostState>{
  final PostRepository repository;

  PostBloc({required this.repository}):super(const PostState.initial()){
    on<FetchPosts>(_onFetchPosts);
  }

  Future<void>_onFetchPosts(FetchPosts event,Emitter <PostState> emit)async
  {
    final currentState=state;
    if (currentState is Success && currentState.hasReachedMax) return;
    try{
      if(currentState is !Success)
      {
        emit (const PostState.loading());
      }
      final page=event.page;
      const limit=10;
      final posts=await repository.fetchPosts(page, limit);
      if(currentState is Success)
      {
        emit(
          PostState.success(posts: currentState.posts+posts, ///combine
              hasReachedMax: posts.isEmpty),
        );
      }else
      {
        emit(PostState.success(posts: posts, hasReachedMax: posts.isEmpty));
      }
    }catch(_){
      emit(const PostState.failure());
    }
  }

}