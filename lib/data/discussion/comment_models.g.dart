// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['id'] as String,
      commentContent: json['commentContent'] as String,
      commenterId: json['commenterId'] as String,
      commenterUsername: json['commenterUsername'] as String,
      commenterProfile: json['commenterProfile'] as String,
      commenterRole: json['commenterRole'] as String,
      discussionId: json['discussionId'] as String,
      discussionTitle: json['discussionTitle'] as String,
      discussionPostContent: json['discussionPostContent'] as String,
      discussionPosterId: json['discussionPosterId'] as String,
      discussionPosterUsername: json['discussionPosterUsername'] as String,
      discussionPosterProfile: json['discussionPosterProfile'] as String,
      discussionPosterRole: json['discussionPosterRole'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'commentContent': instance.commentContent,
      'commenterId': instance.commenterId,
      'commenterUsername': instance.commenterUsername,
      'commenterProfile': instance.commenterProfile,
      'commenterRole': instance.commenterRole,
      'discussionId': instance.discussionId,
      'discussionTitle': instance.discussionTitle,
      'discussionPostContent': instance.discussionPostContent,
      'discussionPosterId': instance.discussionPosterId,
      'discussionPosterUsername': instance.discussionPosterUsername,
      'discussionPosterProfile': instance.discussionPosterProfile,
      'discussionPosterRole': instance.discussionPosterRole,
      'createdAt': instance.createdAt.toIso8601String(),
    };
