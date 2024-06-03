import 'package:stunting_project/data/discussion/comment_models.dart';

class Discussion {
  final String profileImageUrl;
  final String username;
  final String postedTime;
  final String discussionTitle;
  final String discussionReply;
  final List<Comment> comment;

  Discussion({
    required this.profileImageUrl,
    required this.username,
    required this.postedTime,
    required this.discussionTitle,
    required this.discussionReply,
    required this.comment,
  });
}