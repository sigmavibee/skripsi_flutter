import 'package:flutter/material.dart';

class ArticleDetailPage extends StatelessWidget {
  final String title;
  final String author;
  final String date;
  final String imageUrl;
  

  const ArticleDetailPage({
    Key? key,
    required this.title,
    required this.author,
    required this.date,
    required this.imageUrl,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'By $author',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              date,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            // Text(
            //   content,
            //   style: const TextStyle(fontSize: 16),
            // ),
          ],
        ),
      ),
    );
  }
}
