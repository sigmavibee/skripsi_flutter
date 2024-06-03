import 'package:flutter/material.dart';
import 'package:stunting_project/data/article/article_models.dart';
import 'package:stunting_project/data/article/article_list.dart';
import 'package:stunting_project/features/article/screen/articledetail_view.dart';
import 'dart:async';

class ArticlePopular extends StatefulWidget {
  const ArticlePopular({super.key});

  @override
  _ArticlePopularState createState() => _ArticlePopularState();
}

class _ArticlePopularState extends State<ArticlePopular> {
  late PageController _pageController;
  int _currentPage = 0;
  final List<Article> _topArticles = articles.take(3).toList(); // Ambil 3 artikel teratas

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      if (_currentPage < _topArticles.length - 1) {
        setState(() {
          _currentPage++;
        });
      } else {
        setState(() {
          _currentPage = 0;
        });
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        child: PageView.builder(
          controller: _pageController,
          itemCount: _topArticles.length,
          itemBuilder: (context, index) {
            final article = _topArticles[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticleDetailPage(
                      title: article.title,
                      author: article.author,
                      date: article.date,
                      imageUrl: article.imageUrl,
                      content: article.content,
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        article.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'By ${article.author}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          article.date,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                            ),
                  ],
                ),
              ),
              
            );
          },
        ),
      ),
    );
  }
}
