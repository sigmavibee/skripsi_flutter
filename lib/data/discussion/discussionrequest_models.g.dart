// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discussionrequest_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateDiscussionRequest _$CreateDiscussionRequestFromJson(
        Map<String, dynamic> json) =>
    CreateDiscussionRequest(
      title: json['title'] as String,
      postContent: json['post_content'] as String,
    );

Map<String, dynamic> _$CreateDiscussionRequestToJson(
        CreateDiscussionRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'post_content': instance.postContent,
    };
