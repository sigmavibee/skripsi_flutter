import 'dart:async';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late PageController _pageController;
  int _currentPage = 0;
  final List<String> _bannerImages = [
    'https://cdn.bulat.co.id/uploads/images/202302/_1497_683-Situs-Ditebengi-Iklan-Judi-Online--11-Situs-Masih-Aktif.png',
    'https://assets.promediateknologi.id/crop/0x0:0x0/750x500/webp/photo/p1/33/2023/09/13/Judi-Online-2-2533622778.png',
    'https://x.com/sigmavibee/header_photo',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      if (_currentPage < _bannerImages.length - 1) {
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
          itemCount: _bannerImages.length,
          itemBuilder: (context, index) {
            return Image.network(
              _bannerImages[index],
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}
