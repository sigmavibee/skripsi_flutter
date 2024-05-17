import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stunting_project/common/shared_widgets/elevated_button_widget.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/logo_puskesmas.png',
              width: 156.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/logo-new.svg',
                  width: 156.0,
                ),
                const SizedBox(height: 16.0),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    'Tumbuh Sehat, Lawan Stunting Bersama Kami!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton1(
                      labelText: 'Daftar',
                      onPressed: () {
                        Navigator.pushNamed(context, 'register');
                      },
                      backgroundColor: const Color(0xFFFAB317),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sudah punya akun?',
                      style: TextStyle(
                          color: Color(0xFFFFFBFE),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'login');
                        },
                        style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith(
                              (_) => Colors.white.withOpacity(0.1)),
                        ),
                        child: const Text(
                          'Masuk',
                          style: TextStyle(
                              color: Color(0xFFFAB317),
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600),
                        )),
                  ],
                ),
              ],
            ),
            RichText(
                text: const TextSpan(
                    text: '2024 OptimaBalita ',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10.0,
                        color: Colors.white),
                    children: [
                  TextSpan(
                      text: 'All Right Reserved',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 10.0,
                          color: Colors.white70)),
                ]))
          ],
        ),
      ),
    );
  }
}
