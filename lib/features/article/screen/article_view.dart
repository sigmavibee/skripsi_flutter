import 'package:flutter/material.dart';
import 'package:stunting_project/service/article_service.dart';
import '../../../data/article/article_models.dart';

import '../../../tokenmanager.dart';
import '../widget/articlecard_widget.dart';
import 'articledetail_view.dart';

class ArticlePage extends StatefulWidget {
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final ArticleService articleService = ArticleService();
  late Future<List<Article>> futureArticles = Future.value([]);

  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  void _loadArticles() async {
    String? accessToken = await TokenManager.getAccessToken();
    print('Access Token: $accessToken');
    if (accessToken != null) {
      setState(() {
        futureArticles = articleService.getArticles();
      });
    } else {
      // Handle the case where the token is not available
      setState(() {
        futureArticles = Future.error('Access token not found');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Article>>(
        future: futureArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No articles found'));
          } else {
            List<Article> articles = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: articles.map((article) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticleDetailPage(
                              title: article.title,
                              author: article.author,
                              date: article.createdAt.toString(),
                              imageUrl: article.image,
                              content: article.content,
                            ),
                          ),
                        );
                      },
                      child: ArticleCard(
                        title: article.title,
                        author: article.author,
                        date: article.createdAt.toString(),
                        imageUrl: article.image,
                        content: article.content,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}