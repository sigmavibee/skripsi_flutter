import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stunting_project/common/shared_widgets/custom_app_bar.dart';
import 'package:stunting_project/components/app_text_styles.dart';
import 'package:stunting_project/features/home/widget/articlepopular_widget.dart';
import 'package:stunting_project/features/home/widget/profilecard_widget.dart';
import '../../../common/shared_widgets/about_card_widget.dart';
import '../../../common/shared_widgets/bottom_nav_bar.dart';
import '../../../service/auth_service.dart';
import '../widget/banner_widget.dart';

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
  String _appBarTitle = '';
  bool _isLoading = false;
  String? _username;
  String? _avatarUrl;
  String? accessToken;

  final AuthService _authService = AuthService();

  final List<String> _menuItems = [
    'Home',
    'Article',
    'Gizi',
    'Diskusi',
    'Konsultasi',
  ];

  final List<String> _routes = [
    '/',
    'article',
    'gizi',
    'discussion',
    'consultation',
  ];

  @override
  void initState() {
    super.initState();
    _fetchAccessTokenAndUserInfo();
  }

  Future<String?> _getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshToken');
  }

  Future<void> _fetchAccessTokenAndUserInfo() async {
    setState(() {
      _isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    if (accessToken != null) {
      setState(() {
        this.accessToken = accessToken;
      });
      await _fetchUserInfo(accessToken);
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid or expired token. Please login again.'),
        ),
      );
      Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
    }
  }

  Future<void> _fetchUserInfo(String accessToken) async {
    final profileData = await _authService.getUserInfo(accessToken);

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
      final logoutResult = await _authService
          .logout(refreshToken); // Use refresh token for logout
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

  Widget _getBody() {
    return SingleChildScrollView(
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
                  width: 100,
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
          // AboutCardWidget(context: context)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(appBarTitle: 'Home'),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Show loading indicator
          : _getBody(),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        menuItems: _menuItems,
        routes: _routes,
        onTap: (index) {
          Navigator.pushNamed(context, _routes[index]);
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}
