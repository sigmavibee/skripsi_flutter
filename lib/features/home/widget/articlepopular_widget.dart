import 'package:flutter/material.dart';
import 'package:stunting_project/features/article/screen/articledetail_view.dart';



class ArticlePopularCard extends StatelessWidget {
  const ArticlePopularCard({
    super.key,
    required this.title,
    required this.author,
    required this.date,
    required this.imageUrl,
    //required this.content, // Tambahkan konten artikel
  });

  final String title;
  final String author;
  final String date;
  final String imageUrl;
  //final String content; // Tambahkan konten artikel

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleDetailPage(
                title: title,
                author: author,
                date: date,
                imageUrl: imageUrl,
                //content: content, // Tambahkan konten artikel
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                imageUrl,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'By $author',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Text(
                        date,
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
  }
}
