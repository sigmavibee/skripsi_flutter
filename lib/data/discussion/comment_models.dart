import 'package:json_annotation/json_annotation.dart';

part 'comment_models.g.dart';

@JsonSerializable()
class Comment {
  final String id;
  final String commentContent;
  final String commenterId;
  final String commenterUsername;
  final String commenterProfile;
  final String commenterRole;
  final String discussionId;
  final String discussionTitle;
  final String discussionPostContent;
  final String discussionPosterId;
  final String discussionPosterUsername;
  final String discussionPosterProfile;
  final String discussionPosterRole;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.commentContent,
    required this.commenterId,
    required this.commenterUsername,
    required this.commenterProfile,
    required this.commenterRole,
    required this.discussionId,
    required this.discussionTitle,
    required this.discussionPostContent,
    required this.discussionPosterId,
    required this.discussionPosterUsername,
    required this.discussionPosterProfile,
    required this.discussionPosterRole,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] ?? '',
      commentContent: json['comment_content'] ?? '',
      commenterId: json['commenter_id'] ?? '',
      commenterUsername: json['commenter_username'] ?? '',
      commenterProfile: json['commenter_profile'] ?? '',
      commenterRole: json['commenter_role'] ?? '',
      discussionId: json['discussion_id'] ?? '',
      discussionTitle: json['discussion_title'] ?? '',
      discussionPostContent: json['discussion_post_content'] ?? '',
      discussionPosterId: json['discussion_poster_id'] ?? '',
      discussionPosterUsername: json['discussion_poster_username'] ?? '',
      discussionPosterProfile: json['discussion_poster_profile'] ?? '',
      discussionPosterRole: json['discussion_poster_role'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
