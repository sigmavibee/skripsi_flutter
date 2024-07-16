import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ArticleCard extends StatelessWidget {
  final String title;
  final String author;
  final String date;
  final String imageUrl;
  final String content;
  final int
      maxCharacters; // Menambahkan properti untuk menentukan jumlah karakter maksimum

  const ArticleCard({
    Key? key,
    required this.title,
    required this.author,
    required this.date,
    required this.imageUrl,
    required this.content,
    this.maxCharacters = 200, // Default 200 karakter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String limitedContent = content.substring(0,
        maxCharacters); // Ambil karakter pertama hingga maksimum yang ditentukan
    if (content.length > maxCharacters) {
      limitedContent +=
          '...'; // Tambahkan string "..." jika konten lebih panjang dari maxCharacters
    }
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(imageUrl, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('By $author', style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 8),
                Text(date,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 8),
                Html(
                  data: limitedContent,
                  style: {'p': Style(fontSize: FontSize(16))},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
