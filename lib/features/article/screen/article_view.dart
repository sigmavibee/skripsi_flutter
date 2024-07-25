import 'package:flutter/material.dart';
import 'package:stunting_project/common/shared_widgets/bottom_nav_bar.dart';
import 'package:stunting_project/common/shared_widgets/custom_app_bar.dart';
import 'package:stunting_project/data/article/article_models.dart';
import 'package:stunting_project/service/article_service.dart';
import 'package:stunting_project/tokenmanager.dart';

import '../widget/articlecard_widget.dart';
import 'articledetail_view.dart';

class ArticlePage extends StatefulWidget {
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final ArticleService articleService = ArticleService();
  late Future<List<Article>> futureArticles = Future.value([]);
  final List<String> _routes = [
    '/',
    'article',
    'gizi',
    'discussion',
    'consultation',
  ];
  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  void _loadArticles() async {
    String? accessToken = await TokenManager.getAccessToken();
    if (accessToken != null) {
      setState(() {
        futureArticles = articleService.getArticles();
      });
    } else {
      setState(() {
        futureArticles = Future.error('Access token not found');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(
        appBarTitle: 'Artikel',
      ),
      body: FutureBuilder<List<Article>>(
        future: futureArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No articles found'));
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
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        menuItems: [
          'Home',
          'Article',
          'Gizi',
          'Diskusi',
          'Konsultasi',
        ],
        routes: _routes,
        onTap: (index) {
          Navigator.pushNamed(context, _routes[index]);
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}
