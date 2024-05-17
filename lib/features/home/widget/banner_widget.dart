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
    'https://via.placeholder.com/600x200?text=Banner+1',
    'https://via.placeholder.com/600x200?text=Banner+2',
    'https://via.placeholder.com/600x200?text=Banner+3',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    Timer.periodic(Duration(seconds: 10), (Timer timer) {
      if (_currentPage < _bannerImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
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
    return Container(
      height: 200,
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
    );
  }
}
