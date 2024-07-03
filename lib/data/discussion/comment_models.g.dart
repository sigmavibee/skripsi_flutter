// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['id'] as String,
      commentContent: json['comment_content'] as String,
      commenterId: json['commenter_id'] as String,
      commenterUsername: json['commenter_username'] as String,
      commenterProfile: json['commenter_profile'] as String,
      commenterRole: json['commenter_role'] as String,
      discussionId: json['discussion_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'comment_content': instance.commentContent,
      'commenter_id': instance.commenterId,
      'commenter_username': instance.commenterUsername,
      'commenter_profile': instance.commenterProfile,
      'commenter_role': instance.commenterRole,
      'discussion_id': instance.discussionId,
      'created_at': instance.createdAt.toIso8601String(),
    };
