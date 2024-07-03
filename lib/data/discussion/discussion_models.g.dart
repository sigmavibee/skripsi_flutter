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
