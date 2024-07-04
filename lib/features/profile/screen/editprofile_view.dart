import 'dart:io';
import 'package:flutter/material.dart';
import 'package:stunting_project/components/app_text_styles.dart';
import '../../../components/input_widgets.dart';
import '../../../service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import '../../auth/login/screen/login_view.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  bool _isPasswordVisible = false;
  bool _isLoading = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();

  final AuthService _authService = AuthService();
  String? accessToken;
  File? _profileImageFile;
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    setState(() {
      _isLoading = true;
    });

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

    setState(() {
      _isLoading = false;
    });
  }

  Future<String?> _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  Future<void> _updateUserProfile() async {
    if (_usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama tidak boleh kosong')),
      );
      return;
    }

    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email tidak boleh kosong')),
      );
      return;
    }

    if (_oldPasswordController.text.isNotEmpty &&
        _newPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password baru tidak boleh kosong')),
      );
      return;
    } else if (_oldPasswordController.text.isEmpty &&
        _newPasswordController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: const Text('Password lama tidak boleh kosong')),
      );
      return;
    }

    final response = await _authService.updateUserProfile(
      accessToken!, // Menggunakan accessToken yang benar
      _usernameController.text,
      _emailController.text,
      _oldPasswordController.text.isNotEmpty
          ? _oldPasswordController.text
          : null,
      _newPasswordController.text.isNotEmpty
          ? _newPasswordController.text
          : null,
      _profileImageFile, // Pastikan ini adalah file yang dipilih
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response['message'])),
    );

    if (response['success']) {
      Navigator.of(context).pop(); // Close the profile edit page
    } else if (response['status'] ==
        'Invalid or Expired token. Please login again.') {
      // Navigate to the login page if token is invalid or expired
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final String fileExtension =
          pickedFile.path.split('.').last.toLowerCase();
      if (fileExtension == 'jpeg' ||
          fileExtension == 'jpg' ||
          fileExtension == 'png') {
        setState(() {
          _profileImageFile = File(pickedFile.path);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Hanya file JPEG, JPG, dan PNG yang diperbolehkan.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      backgroundImage: _profileImageFile != null
                          ? FileImage(_profileImageFile!)
                          : _profileImageUrl != null
                              ? NetworkImage(_profileImageUrl!)
                              : const AssetImage('assets/avatar.jpg')
                                  as ImageProvider,
                      radius: 50,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
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
                  InputLayoutCus(
                    'Password Baru',
                    TextFormField(
                      controller: _newPasswordController,
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
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 3,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(Colors.red),
                            foregroundColor:
                                WidgetStateProperty.all<Color>(Colors.black),
                            textStyle: WidgetStateProperty.all<TextStyle>(
                              AppTextStyle.body2Medium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          child: const Text('Logout'),
                        ),
                      ),
                      const SizedBox(
                          width: 10), // Add this line (10 pixels spacing)
                      Expanded(
                        flex: 3,
                        child: ElevatedButton(
                          onPressed: _updateUserProfile,
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(Colors.red),
                            foregroundColor:
                                WidgetStateProperty.all<Color>(Colors.black),
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
