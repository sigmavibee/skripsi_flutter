import 'package:flutter/material.dart';

import 'articledetail_view.dart';

class ArticlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildArticleCard(
            context: context, // Pass the context
            title: 'The Importance of Healthy Eating',
            author: 'John Doe',
            date: 'May 1, 2024',
            imageUrl: 'https://via.placeholder.com/150',
          ),
          SizedBox(height: 16),
          _buildArticleCard(
            context: context, // Pass the context
            title: 'Exercises for Better Posture',
            author: 'Jane Smith',
            date: 'April 25, 2024',
            imageUrl: 'https://via.placeholder.com/150',
          ),
          SizedBox(height: 16),
          _buildArticleCard(
            context: context, // Pass the context
            title: 'Understanding Nutrition Labels',
            author: 'David Johnson',
            date: 'April 20, 2024',
            imageUrl: 'https://via.placeholder.com/150',
          ),
        ],
      ),
    );
  }

  Widget _buildArticleCard({
    required BuildContext context, // Add BuildContext parameter
    required String title,
    required String author,
    required String date,
    required String imageUrl,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ArticleDetailPage(title: '', author: '', date: '', imageUrl: '', content: '',)),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                imageUrl,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'By $author',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        date,
                        style: TextStyle(color: Colors.grey),
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
  }
}
