import 'package:flutter/material.dart';

import '../widget/articlecard_widget.dart';
import 'articledetail_view.dart';

class ArticlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ArticleCard(context: context, title: 'The Importance of Healthy Eating', author: 'John Doe', date: 'May 1, 2024', imageUrl: 'https://via.placeholder.com/150'),
          const SizedBox(height: 16),
          ArticleCard(context: context, title: 'Exercises for Better Posture', author: 'Jane Smith', date: 'April 25, 2024', imageUrl: 'https://via.placeholder.com/150'),
          const SizedBox(height: 16),
          ArticleCard(context: context, title: 'Understanding Nutrition Labels', author: 'David Johnson', date: 'April 20, 2024', imageUrl: 'https://via.placeholder.com/150'),
        ],
      ),
    );
  }
}

