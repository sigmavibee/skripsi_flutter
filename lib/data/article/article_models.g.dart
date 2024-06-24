// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      id: json['id'] as String,
      slug: json['slug'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      content: json['content'] as String,
      image: json['image'] as String,
      author: json['author'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'title': instance.title,
      'description': instance.description,
      'content': instance.content,
      'image': instance.image,
      'author': instance.author,
      'created_at': instance.createdAt.toIso8601String(),
    };
