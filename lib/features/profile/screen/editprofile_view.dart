import 'package:flutter/material.dart';
import 'package:stunting_project/components/app_text_styles.dart';
import '../../../components/input_widgets.dart';
import '../../../service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  bool _isPasswordVisible = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  final AuthService _authService = AuthService();
  String? accessToken;
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    accessToken = await _getAccessToken();

    if (accessToken != null) {
      final response = await _authService.getUserInfo(accessToken!);
      if (response['success']) {
        final data = response['data'];
        setState(() {
          _usernameController.text = data['username'];
          _emailController.text = data['email'];
          _profileImageUrl = data['profile'];
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'])),
        );
      }
    }
  }

  Future<String?> _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: CircleAvatar(
                backgroundImage: _profileImageUrl != null
                    ? NetworkImage(_profileImageUrl!)
                    : AssetImage('assets/avatar.jpg') as ImageProvider,
                radius: 50,
              ),),
            const SizedBox(height: 5),
            Text(
              'Klik untuk mengubah foto',
              style: AppTextStyle.body3Regular,
            ),
            const SizedBox(height: 5),
            InputLayoutCus(
              'Nama',
              TextFormField(
                controller: _usernameController,
                decoration: customInputDecoration("Masukkan nama anda"),
              ),
            ),
            const SizedBox(height: 5),
            InputLayoutCus(
              'Email',
              TextFormField(
                controller: _emailController,
                decoration: customInputDecoration("Masukkan email anda"),
              ),
            ),
            const SizedBox(height: 5),
            InputLayoutCus(
              'Password Lama',
              TextFormField(
                controller: _oldPasswordController,
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
            InputLayoutCus(
              'Password Baru',
              TextFormField(
                controller: _newPasswordController,
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
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle logout action
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
                      foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
                      textStyle: WidgetStateProperty.all<TextStyle>(
                        AppTextStyle.body2Medium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    child: const Text('Logout'),
                  ),
                ),
                const SizedBox(width: 10), // Add this line (10 pixels spacing)
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle submit action
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
                      foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
                      textStyle: WidgetStateProperty.all<TextStyle>(
                        AppTextStyle.body2Medium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
