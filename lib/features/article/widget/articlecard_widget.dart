import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ArticleCard extends StatelessWidget {
  final String title;
  final String author;
  final String date;
  final String imageUrl;
  final String content;
  final int maxCharacters; // Menambahkan properti untuk menentukan jumlah karakter maksimum

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
    String limitedContent = content.substring(0, maxCharacters); // Ambil karakter pertama hingga maksimum yang ditentukan
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('By $author', style: TextStyle(fontSize: 14)),
                SizedBox(height: 8),
                Text(date, style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 8),
                Html(
                  data: limitedContent,
                  style: {'p': Style(fontSize: FontSize(16))},
                ),
                if (content.length > maxCharacters) // Tampilkan tombol untuk membuka seluruh konten jika lebih panjang
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Full Content'),
                            content: SingleChildScrollView(
                              child: Html(data: content),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Klik untuk membaca selengkapnya'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
