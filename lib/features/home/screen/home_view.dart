import 'package:flutter/material.dart';
import 'package:stunting_project/components/app_text_styles.dart';
import 'package:stunting_project/components/colors.dart';

import '../../article/screen/article_view.dart';
import '../../gizi/screen/gizi_view.dart';
import '../widget/banner_widget.dart'; // Import GiziPage

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          _appBarTitle = 'Home';
          break;
        case 1:
          _appBarTitle = 'Article';
          break;
        
      }
    });

    // Menampilkan halaman yang sesuai dengan item yang dipilih
    if (index == 2) {
      Navigator.pushNamed(context, 'gizi');
    }
    if (index == 3) {
      Navigator.pushNamed(context, 'discussion');
    }
    if (index == 4) {
      Navigator.pushNamed(context, 'consultation');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle, style: AppTextStyle.heading4Bold), automaticallyImplyLeading: false,  actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app), // Icon logout
            onPressed: () {Navigator.pushNamed(context, 'login');
              // Aksi logout
            },
          ),
        ],
      ),
      body: _selectedIndex == 0 // Check if _selectedIndex is 0 (Home)
          ? Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/avatar.jpg'),
                        radius: 30,
                      ),
                      SizedBox(width: 16),
                      Text(
                        'Charles Leclerc',
                        style: AppTextStyle.body2Bold,
                      ),
                    ],
                  ),
                ), BannerWidget(),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text('Main Content'),
                  ),
                ),
              ],
            )
          : ArticlePage(), // Show ArticlePage if _selectedIndex is not 0
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
