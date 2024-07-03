import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stunting_project/components/app_text_styles.dart';
import 'package:stunting_project/components/colors.dart';
import 'package:stunting_project/features/home/widget/articlepopular_widget.dart';
import 'package:stunting_project/features/home/widget/profilecard_widget.dart';
import '../widget/banner_widget.dart';
import '../../article/screen/article_view.dart';
import '../../../service/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeFull();
  }
}

class HomeFull extends StatefulWidget {
  const HomeFull({super.key});

  @override
  State<StatefulWidget> createState() => _HomeFull();
}

class _HomeFull extends State<HomeFull> {
  int _selectedIndex = 0;
  String _appBarTitle = 'Home';
  String _previousAppBarTitle = '';
  bool _isLoading = false;
  String? _username;
  String? _avatarUrl;

  final AuthService _authService = AuthService();
  String? accessToken;

  @override
  void initState() {
    super.initState();
    _fetchAccessToken();
  }

  Future<String?> _getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshToken');
  }
  Future<String?> _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  Future<void> _fetchAccessToken() async {
  setState(() {
    _isLoading = true;
  });

  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('accessToken');
  if (accessToken != null) {
    final profileData = await _authService.getUserInfo(accessToken);
    if (profileData['success']) {
      setState(() {
        _username = profileData['data']['username'];
        _avatarUrl = profileData['data']['profile'];
        _isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid or expired token. Please login again.'),
        ),
      );
      Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
    }
  } else {
    setState(() {
      _isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Invalid or expired token. Please login again.'),
      ),
    );
    Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
  }
}

  Future<void> _fetchUserInfo(String accessToken) async {
    final profileData = await _authService.getUserInfo(accessToken);
    print('Access Token: $accessToken');
    if (profileData['success']) {
      setState(() {
        _username = profileData['data']['username'];
        _avatarUrl = profileData['data']['profile'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(profileData['message'])),
      );
    }
  }

  Future<void> _logoutUser() async {
    final refreshToken = await _getRefreshToken(); // Retrieve refresh token
    if (refreshToken != null) {
      final logoutResult = await _authService.logout(refreshToken); // Use refresh token for logout
      if (logoutResult['success']) {
        await _clearTokens();
        Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(logoutResult['message'])),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No refresh token found.')),
      );
    }
  }

  Future<void> _clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
  }

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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/logo_puskesmas.png',
              width: 20,
              height: 25,
              fit: BoxFit.contain,
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/logo_puskesmas.png'),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
      body: _isLoading
        ? const Center(child: CircularProgressIndicator()) // Show loading indicator
        : _selectedIndex == 0
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 7, // Takes 7/8 of the space
                          child: ProfileCard(
                            username: _username,
                            avatarUrl: _avatarUrl,
                            onTap: () {
                              Navigator.pushNamed(context, 'profile');
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1, // Takes 1/8 of the space
                          child: SizedBox(
                            height: 100,
                            child: Card(
                              child: IconButton(
                                icon: const Icon(Icons.exit_to_app),
                                onPressed: _logoutUser,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    BannerWidget(),
                    const Text('Artikel Populer', style: AppTextStyle.heading5Bold),
                    const SizedBox(
                      height: 268, // Set a height to avoid overflow error
                      child: ArticlePopular(),
                    ),
                  ],
                ),
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
}}