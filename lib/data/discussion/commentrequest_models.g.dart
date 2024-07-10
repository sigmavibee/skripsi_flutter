// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commentrequest_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCommentRequest _$CreateCommentRequestFromJson(
        Map<String, dynamic> json) =>
    CreateCommentRequest(
      commentContent: json['comment_content'] as String,
    );

Map<String, dynamic> _$CreateCommentRequestToJson(
        CreateCommentRequest instance) =>
    <String, dynamic>{
      'post_content': instance.commentContent,
    };
