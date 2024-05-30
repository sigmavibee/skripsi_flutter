import 'package:flutter/material.dart';
import 'package:stunting_project/components/app_text_styles.dart';
import 'package:stunting_project/components/colors.dart';
import 'package:stunting_project/features/home/widget/articlepopular_widget.dart';
import 'package:stunting_project/features/home/widget/profilecard_widget.dart';
import '../widget/banner_widget.dart';
import '../../article/screen/article_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeFull();
  }
}

class HomeFull extends StatefulWidget {
  const HomeFull({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeFull();
}

class _HomeFull extends State<HomeFull> {
  int _selectedIndex = 0;
String _appBarTitle = 'Home';
String _previousAppBarTitle = 'Home';

Future<void> _onItemTapped(int index) async {
  if (index == 2 || index == 3 || index == 4) {
    int previousIndex = _selectedIndex;
    final result = await Navigator.pushNamed(context, _getRouteName(index));
    if (result != null && result is int) {
      setState(() {
        _selectedIndex = result;
        _appBarTitle = _getAppBarTitle(result);
      });
    } else {
      setState(() {
        _selectedIndex = previousIndex;
        _appBarTitle = _previousAppBarTitle;
      });
    }
  } else {
    setState(() {
      _selectedIndex = index;
      _previousAppBarTitle = _appBarTitle;
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
                ProfileCard(
                  onTap: () {
                    Navigator.pushNamed(context, 'profile');
                  },
                ),
                BannerWidget(),
                Text('Artikel Populer', style: AppTextStyle.heading5Bold),
                Expanded(
                  child: ArticlePopular()
                ),
              ],
            )
          : ArticlePage(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: successColor,
        selectedFontSize: 14,
        unselectedItemColor: Colors.grey[800],
        unselectedFontSize: 12,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'Artikel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank_outlined),
            label: 'Gizi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: 'Diskusi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_outlined),
            label: 'Konsultasi',
          ),
        ],
      ),
    );
  }
}
