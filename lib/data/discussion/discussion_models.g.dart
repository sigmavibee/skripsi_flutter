// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discussion_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Discussion _$DiscussionFromJson(Map<String, dynamic> json) => Discussion(
      id: json['id'] as String,
      title: json['title'] as String,
      postContent: json['post_content'] as String,
      posterId: json['poster_id'] as String,
      posterUsername: json['poster_username'] as String,
      posterProfile: json['poster_profile'] as String,
      posterRole: json['poster_role'] as String,
      commentCount: (json['comment_count'] as num).toInt(),
      likeCount: (json['like_count'] as num).toInt(),
      isLiked: json['is_liked'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DiscussionToJson(Discussion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'post_content': instance.postContent,
      'poster_id': instance.posterId,
      'poster_username': instance.posterUsername,
      'poster_profile': instance.posterProfile,
      'poster_role': instance.posterRole,
      'comment_count': instance.commentCount,
      'like_count': instance.likeCount,
      'is_liked': instance.isLiked,
      'created_at': instance.createdAt.toIso8601String(),
      'comments': instance.comments,
    };

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
