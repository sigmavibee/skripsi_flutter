import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stunting_project/components/app_text_styles.dart';
import 'package:stunting_project/components/input_widgets.dart';

import '../../../../service/auth_service.dart';
import '../../../home/screen/home_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  Future<void> _storeTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
    await prefs.setString('refreshToken', refreshToken);
  }

  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    final result = await _authService.login(email, password);

    if (result['success']) {
      // Store the tokens
      await _storeTokens(result['accessToken'], result['refreshToken']);

      // Navigate to the home page after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      _showAlertDialog(result['message']);
    }
  }

  void _showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Masuk',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.heading3Bold.copyWith(
                    color: const Color.fromARGB(255, 34, 14, 14),
                  ),
                ),
                const SizedBox(height: 6.0),
                Row(
                  children: [
                    Flexible(
                      child: Image.asset(
                        'assets/icon_bg.png',
                        width: MediaQuery.of(context).size.height * 0.45,
                        height: MediaQuery.of(context).size.height * 0.45,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Silahkan login untuk melanjutkan!',
                  style: AppTextStyle.body2Medium.copyWith(color: Colors.black),
                ),
                InputLayout(
                  'Email',
                  TextFormField(
                    controller: _emailController,
                    decoration:
                        customInputDecoration('Masukkan alamat email anda'),
                  ),
                ),
                InputLayout(
                  'Password',
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration:
                        customInputDecoration('Masukkan password').copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: double.infinity,
                  child: FilledButton(
                    style: buttonStyle,
                    child: Text(
                      'Masuk',
                      style: AppTextStyle.body2Medium.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _login, // Call the login function
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Belum punya akun?',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'register');
                        },
                        style: ButtonStyle(
                          overlayColor: WidgetStateColor.resolveWith(
                              (_) => Colors.white.withOpacity(0.1)),
                        ),
                        child: const Text(
                          'Membuat akun',
                          style: TextStyle(
                              color: Color(0xFFFAB317),
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
