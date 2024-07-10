import 'package:json_annotation/json_annotation.dart';

part 'commentrequest_models.g.dart';

@JsonSerializable()
class CreateCommentRequest {
  @JsonKey(name: 'comment_content')
  final String commentContent;

  CreateCommentRequest({
    required this.commentContent,
  });

  factory CreateCommentRequest.fromJson(Map<String, dynamic> json) {
    try {
      return CreateCommentRequest(
        commentContent: json['post_content'] as String? ?? '',
      );
    } catch (e) {
      throw FormatException(
          'Invalid CreateCommentRequest JSON format: ${e.toString()}');
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return {
        'comment_content': commentContent,
      };
    } catch (e) {
      throw FormatException(
          'Error converting CreateCommentRequest to JSON: ${e.toString()}');
    }
  }
}
