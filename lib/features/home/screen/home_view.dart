import 'package:flutter/material.dart';
import 'package:stunting_project/components/app_text_styles.dart';
import 'package:stunting_project/components/colors.dart';
import 'package:stunting_project/features/home/widget/articlepopular_widget.dart';

import '../../article/screen/article_view.dart';
import '../../gizi/screen/gizi_view.dart';
import '../widget/banner_widget.dart';
import '../widget/profilecard_widget.dart'; // Import GiziPage

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return const HomeFull();
  }
}

class HomeFull extends StatefulWidget {
  const HomeFull({Key? key});

  @override
  State<StatefulWidget> createState() => _HomeFull();
}

class _HomeFull extends State<HomeFull> {
  int _selectedIndex = 0;
  String _appBarTitle = 'Home';

  Future<void> _onItemTapped(int index) async {
    if (index == 2 || index == 3 || index == 4) {
      // Save the current index before navigating
      int previousIndex = _selectedIndex;

      // Navigate to the new page and wait for the result
      final result = await Navigator.pushNamed(context, _getRouteName(index));

      // Check if a result was returned and set the _selectedIndex accordingly
      if (result != null && result is int) {
        setState(() {
          _selectedIndex = result;
        });
      } else {
        // If no result is returned, go back to the previous index
        setState(() {
          _selectedIndex = previousIndex;
        });
      }
    } else {
      setState(() {
        _selectedIndex = index;
        _appBarTitle = _getAppBarTitle(index);
      });
    }
  }

  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Article';
      default:
        return 'Home';
    }
  }

  String _getRouteName(int index) {
    switch (index) {
      case 2:
        return 'gizi';
      case 3:
        return 'discussion';
      case 4:
        return 'consultation';
      default:
        return 'home';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: successColor,
        title: Text(_appBarTitle, style: AppTextStyle.heading4Bold),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushNamed(context, 'login');
            },
          ),
        ],
      ),
      body: _selectedIndex == 0
          ? Column(
              children: [
                ProfileCard(),
                BannerWidget(),
                Expanded(
                  child: ArticlePopularCard(context: context, title: 'The Importance of Healthy Eating', author: 'John Doe', date: 'May 1, 2024', imageUrl: 'https://via.placeholder.com/150'
                  ),
                ),
              ],
            )
          : ArticlePage(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF000000),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: successColor,
        selectedFontSize: 14,
        unselectedItemColor: Colors.grey[800],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'Article',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank_outlined),
            label: 'Gizi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: 'Discussion',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_outlined),
            label: 'Consultation',
          ),
        ],
      ),
    );
  }
}

