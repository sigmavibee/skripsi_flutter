import 'package:json_annotation/json_annotation.dart';

part 'article_models.g.dart';

@JsonSerializable()
class Article {
  final String id;
  final String slug;
  final String title;
  final String description;
  final String content;
  final String image;
  final String author;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  Article({
    required this.id,
    required this.slug,
    required this.title,
    required this.description,
    required this.content,
    required this.image,
    required this.author,
    required this.createdAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
