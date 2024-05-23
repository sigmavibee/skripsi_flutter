import 'package:flutter/material.dart';
import 'package:stunting_project/components/app_text_styles.dart';
import 'package:stunting_project/components/input_widgets.dart';
import 'package:stunting_project/features/home/screen/home_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;

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
                    
                    'Masuk',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.heading4Bold
                        .copyWith(color: const Color.fromARGB(255, 34, 14, 14)),
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    'Masukkan kredensial anda untuk masuk ke akun',
                    style: AppTextStyle.body2Medium.copyWith(color: Colors.black),
                  ),
                  InputLayout(
                    'Email',
                    TextFormField(
                      
                      onChanged: (String value) => (() {}),
                      //validator: noEmptyValidator,
                      decoration: customInputDecoration('Masukkan alamat email anda'),
                    ),
                  ),
                  InputLayout(
                    'Password',
                    TextFormField(
                      obscureText: !_isPasswordVisible,
                      onChanged: (String value) => (() {}),
                      //validator: noEmptyValidator,
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
                        'Masuk',
                        style: AppTextStyle.body2Medium.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
