import 'package:json_annotation/json_annotation.dart';

part 'discussionrequest_models.g.dart';

@JsonSerializable()
class CreateDiscussionRequest {
  final String title;
  @JsonKey(name: 'post_content')
  final String postContent;

  CreateDiscussionRequest({
    required this.title,
    required this.postContent,
  });

  factory CreateDiscussionRequest.fromJson(Map<String, dynamic> json) {
    try {
      return CreateDiscussionRequest(
        title: json['title'] as String? ?? '',
        postContent: json['post_content'] as String? ?? '',
      );
    } catch (e) {
      throw FormatException(
          'Invalid CreateDiscussionRequest JSON format: ${e.toString()}');
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return {
        'title': title,
        'post_content': postContent,
      };
    } catch (e) {
      throw FormatException(
          'Error converting CreateDiscussionRequest to JSON: ${e.toString()}');
    }
  }
}
