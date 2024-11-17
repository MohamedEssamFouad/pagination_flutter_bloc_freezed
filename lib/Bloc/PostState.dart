

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pagination_flutter_bloc_freezed/Model/Model.dart';
part 'PostState.freezed.dart';

@freezed
class PostState with _$PostState
{
  const factory PostState.initial()=intial;
  const factory PostState.loading()=loading;
  const factory PostState.success({
    required List<Post>posts,
    required bool hasReachedMax,
})=Success;
  const factory PostState.failure()=Failure;
}