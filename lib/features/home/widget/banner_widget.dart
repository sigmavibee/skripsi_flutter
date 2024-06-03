import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stunting_project/features/home/widget/promotion_widget.dart';

class BannerWidget extends StatefulWidget {
  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late PageController _pageController;
  int _currentPage = 0;
  final List<Map<String, dynamic>> _bannerData = [
    {
      'icon': Icons.calculate_rounded,
      'iconColor': Colors.pink,
      'title': 'Pantau Tumbuh Kembang Anak',
      'description': 'Fitur BMI Calculator di Stunting Center telah dilengkapi dengan riwayat perhitungan, sehingga memudahkan pemantauan pertumbuhan anak'
    },
    {
      'icon': Icons.book_rounded,
      'iconColor': Colors.blue,
      'title': 'Informasi Stunting Terlengkap',
      'description': 'Dapatkan informasi mengenai stunting, pencegahan serta penanganan stunting terlengkap disini'
    },
    {
      'icon': Icons.chat_rounded,
      'iconColor': Colors.green,
      'title': 'Forum Diskusi Stunting',
      'description': 'Forum diskusi merupakan tempat yang aman untuk memberikan kesempatan dan dukungan dalam upaya mengatasi masalah stunting'
    },
    // Add more promotional data here
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      if (_currentPage < _bannerData.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
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
          itemCount: _bannerData.length,
          itemBuilder: (context, index) {
            return PromotionBanner(
              icon: _bannerData[index]['icon'],
              iconColor: _bannerData[index]['iconColor'],
              title: _bannerData[index]['title'],
              description: _bannerData[index]['description'],
            );
          },
        ),
      ),
    );
  }
}
