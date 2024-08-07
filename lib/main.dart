import 'package:flutter/material.dart';
import 'package:stunting_project/features/about/about_view.dart';

import 'package:stunting_project/features/profile/screen/editprofile_view.dart';
import 'package:stunting_project/features/splash/splash_page.dart';

import 'features/article/screen/article_view.dart';
import 'features/auth/login/screen/login_view.dart';
import 'features/auth/register/screen/register_view.dart';
import 'features/consult/screen/consultation_view.dart';

import 'features/discussion/screen/discussion_view.dart';
import 'features/gizi/screen/gizi_view.dart';
import 'features/gizi/screen/gizihistory_view.dart';
import 'features/home/screen/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stunting App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'splash',
      routes: {
        'splash': (context) => const SplashPage(),
        'login': (context) => const LoginPage(),
        'register': (context) => const RegisterPage(),
        '/': (context) => HomePage(),
        'article': (context) => ArticlePage(),
        'gizi': (context) => GiziPage(),
        'gizihistory': (context) => GiziHistoryPage(),
        'discussion': (context) => DiscussionPage(),
        'consultation': (context) => ConsultationPage(),
        'profile': (context) => const ProfileEdit(),
        'about': (context) => AboutPage()
      },
    );
  }
}
