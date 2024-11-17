
import 'package:freezed_annotation/freezed_annotation.dart';

part 'PostEvent.freezed.dart';

@freezed
class PostEvent with _$PostEvent
{
  const factory PostEvent.fetchPosts({required int page})=FetchPosts;
}