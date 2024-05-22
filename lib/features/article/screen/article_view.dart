import 'package:flutter/material.dart';

import '../widget/articlecard_widget.dart';
import '../../../data/article/listarticle_models.dart';

class ArticlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: articles.map((article) {
          return Column(
            children: [
              ArticleCard(
                title: article.title,
                author: article.author,
                date: article.date,
                imageUrl: article.imageUrl,
              ),
              const SizedBox(height: 16),
            ],
          );
        }).toList(),
      ),
    );
  }
}