import 'package:json_annotation/json_annotation.dart';

part 'comment_models.g.dart';

@JsonSerializable()
class Comment {
  final String id;
  @JsonKey(name: 'comment_content')
  final String commentContent;
  @JsonKey(name: 'commenter_id')
  final String commenterId;
  @JsonKey(name: 'commenter_username')
  final String commenterUsername;
  @JsonKey(name: 'commenter_profile')
  final String commenterProfile;
  @JsonKey(name: 'commenter_role')
  final String commenterRole;
  @JsonKey(name: 'discussion_id')
  final String discussionId;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.commentContent,
    required this.commenterId,
    required this.commenterUsername,
    required this.commenterProfile,
    required this.commenterRole,
    required this.discussionId,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}