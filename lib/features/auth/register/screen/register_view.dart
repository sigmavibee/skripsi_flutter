import 'package:flutter/material.dart';
import 'package:stunting_project/components/app_text_styles.dart';
import 'package:stunting_project/components/input_widgets.dart';
import 'package:stunting_project/features/auth/login/screen/login_view.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                  Text('Daftar',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.heading4Bold
                          .copyWith(color: const Color.fromARGB(255, 34, 14, 14))),
                  const SizedBox(height: 24.0),
                  Text('Masukan data diri anda untuk membuat akun',
                      style: AppTextStyle.body2Medium
                          .copyWith(color: Colors.black)),
                  InputLayout(
                      'Nama',
                      TextFormField(
                          onChanged: (String value) => (() {}),
                          //validator: noEmptyValidator,
                          decoration:
                              customInputDecoration("Masukkan nama anda"))),
                  InputLayout(
                      'Email',
                      TextFormField(
                        onChanged: (String value) => (() {}),
                        //validator: noEmptyValidator,
                        decoration:
                            customInputDecoration('Masukkan alamat email anda'),
                      )),
                  InputLayout(
                      'Password',
                      TextFormField(
                          onChanged: (String value) => (() {}),
                          //validator: noEmptyValidator,
                          decoration:
                              customInputDecoration("Masukkan password"))),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: double.infinity,
                    child: FilledButton(
                        style: buttonStyle,
                        child: Text('Daftar',
                            style: AppTextStyle.body2Medium.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {}),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sudah punya akun?',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400),
                      ),
                      TextButton(
                          onPressed: () {
                             Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                     builder: (context) => const LoginPage()));
                          },
                          style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                                (_) => Colors.black.withOpacity(0.1)),
                          ),
                          child: const Text(
                            'Masuk',
                            style: TextStyle(
                                color: Color((0xFFFAB317)),
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  )
                ])),
            // if (state.status.isSubmissionInProgress)
            //   Container(
            //       width: MediaQuery.of(context).size.width,
            //       height: MediaQuery.of(context).size.height,
            //       color: Colors.black54,
            //       child: const Center(child: CircularProgressIndicator.adaptive())),
          ],
        ),
      ),
    );
  }
}
