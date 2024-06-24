import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stunting_project/data/article/article_models.dart';
import 'package:stunting_project/service/article_service.dart';
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
  List<Article> _topArticles = [];
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _fetchTopArticles();
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

  Future<void> _fetchTopArticles() async {
    try {
      final articles = await ArticleService().getArticles(limit: 3);
      setState(() {
        _topArticles = articles.take(3).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error.isNotEmpty) {
      return Center(child: Text(_error));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: constraints.maxHeight,
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
                          date: article.createdAt.toIso8601String(),
                          imageUrl: article.image,
                          content: article.content,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              article.image,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article.title,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    article.author,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    DateFormat('dd/MM/yyyy').format(article.createdAt),
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
      },
    );
  }
}
