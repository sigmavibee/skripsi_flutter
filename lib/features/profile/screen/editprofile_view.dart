import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Edit Profile'),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const CircleAvatar(
            backgroundImage: AssetImage('assets/avatar.jpg'),
            radius: 30,
          ),
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nama',
            ),
          ),
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(
              
              border: OutlineInputBorder(),
              labelText: 'Alamat',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(Icons.visibility),
                onPressed: () {
                  // Handle visibility action
                },
              ),
              border: const OutlineInputBorder(),
              labelText: 'Password',
            ),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle submit action
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    ),
  );
}
  }
