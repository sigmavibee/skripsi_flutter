import 'package:json_annotation/json_annotation.dart';
import 'comment_models.dart';

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

  // Factory constructor to create a Discussion instance from JSON with error handling
  factory Discussion.fromJson(Map<String, dynamic> json) {
    try {
      return Discussion(
        id: json['id'] as String? ?? '',
        title: json['title'] as String? ?? '',
        postContent: json['post_content'] as String? ?? '',
        posterId: json['poster_id'] as String? ?? '',
        posterUsername: json['poster_username'] as String? ?? '',
        posterProfile: json['poster_profile'] as String? ?? '',
        posterRole: json['poster_role'] as String? ?? '',
        commentCount: json['comment_count'] as int? ?? 0,
        likeCount: json['like_count'] as int? ?? 0,
        isLiked: json['is_liked'] as bool? ?? false,
        createdAt: DateTime.parse(
            json['created_at'] as String? ?? DateTime.now().toIso8601String()),
        comments: (json['comments'] as List<dynamic>?)
            ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      throw FormatException('Invalid Discussion JSON format: ${e.toString()}');
    }
  }

  // Method to convert a Discussion instance to JSON with error handling
  Map<String, dynamic> toJson() {
    try {
      return _$DiscussionToJson(this);
    } catch (e) {
      throw FormatException(
          'Error converting Discussion to JSON: ${e.toString()}');
    }
  }
}
