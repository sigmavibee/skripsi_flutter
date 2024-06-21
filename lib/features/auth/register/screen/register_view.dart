import 'package:flutter/material.dart';
import 'package:stunting_project/components/app_text_styles.dart';
import 'package:stunting_project/components/input_widgets.dart';
import 'package:stunting_project/features/auth/login/screen/login_view.dart';
import '../../../../service/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isPasswordVisible = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  Future<void> _register() async {
    print('Register button clicked');
    final String username = _usernameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;

    final result = await _authService.register(username, email, password);

    print('Registration result: $result');

    if (result['success']) {
      // Navigate to the login page after successful registration
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );

      // You can handle the registered user data as required
      print('Registered Username: ${result['data']['username']}');
      print('Registered Email: ${result['data']['email']}');
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
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            SafeArea(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(32.0),
                children: [
                  Text(
                    'Daftar',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.heading4Bold
                        .copyWith(color: const Color.fromARGB(255, 34, 14, 14)),
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    'Masukan data diri anda untuk membuat akun',
                    style: AppTextStyle.body2Medium.copyWith(color: Colors.black),
                  ),
                  InputLayout(
                    'Nama',
                    TextFormField(
                      controller: _usernameController,
                      decoration: customInputDecoration("Masukkan nama anda"),
                    ),
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
                    margin: const EdgeInsets.only(top: 20),
                    width: double.infinity,
                    child: FilledButton(
                      style: buttonStyle,
                      child: Text(
                        'Daftar',
                        style: AppTextStyle.body2Medium.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _register, // Call the register function
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sudah punya akun?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          overlayColor: WidgetStateColor.resolveWith(
                            (_) => Colors.black.withOpacity(0.1),
                          ),
                        ),
                        child: const Text(
                          'Masuk',
                          style: TextStyle(
                            color: Color(0xFFFAB317),
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // if (state.status.isSubmissionInProgress)
            //   Container(
            //     width: MediaQuery.of(context).size.width,
            //     height: MediaQuery.of(context).size.height,
            //     color: Colors.black54,
            //     child: const Center(child: CircularProgressIndicator.adaptive()),
            //   ),
          ],
        ),
      ),
    );
  }
}