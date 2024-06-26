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
          builder: (context) =>  HomePage(),
        ),
      );

      print('Refresh Token: ${result['refreshToken']}');
      print('Access Token: ${result['accessToken']}');
    } else {
      _showSnackBar(result['message']);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
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
                Text(
                  'Masukkan kredensial anda untuk masuk ke akun',
                  style: AppTextStyle.body2Medium.copyWith(color: Colors.black),
                ),
                InputLayout(
                  'Email',
                  TextFormField(
                    controller: _emailController,
                    decoration: customInputDecoration('Masukkan alamat email anda'),
                  ),
                ),
                InputLayout(
                  'Password',
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: customInputDecoration('Masukkan password').copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

