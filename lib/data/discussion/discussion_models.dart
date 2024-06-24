import 'package:json_annotation/json_annotation.dart';

part 'discussion_models.g.dart';

@JsonSerializable()
class Discussion {
  final String id;
  final String title;
  @JsonKey(name: 'post_content')
  final String postContent;
  @JsonKey(name: 'poster_id')
  final String posterId;
  @JsonKey(name: 'poster_username')
  final String posterUsername;
  @JsonKey(name: 'poster_profile')
  final String posterProfile;
  @JsonKey(name: 'poster_role')
  final String posterRole;
  @JsonKey(name: 'comment_count')
  final int commentCount;
  @JsonKey(name: 'like_count')
  final int likeCount;
  @JsonKey(name: 'is_liked')
  final bool isLiked;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  final List<Comment>? comments;

  Discussion({
    required this.id,
    required this.title,
    required this.postContent,
    required this.posterId,
    required this.posterUsername,
    required this.posterProfile,
    required this.posterRole,
    required this.commentCount,
    required this.likeCount,
    required this.isLiked,
    required this.createdAt,
    this.comments,
  });

  factory Discussion.fromJson(Map<String, dynamic> json) => _$DiscussionFromJson(json);
  Map<String, dynamic> toJson() => _$DiscussionToJson(this);
}

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
