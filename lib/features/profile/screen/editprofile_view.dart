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
      title: Text('Edit Profile'),
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage('assets/avatar.jpg'),
            radius: 30,
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nama',
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              
              border: OutlineInputBorder(),
              labelText: 'Alamat',
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.visibility),
                onPressed: () {
                  // Handle visibility action
                },
              ),
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
            obscureText: true,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle submit action
            },
            child: Text('Submit'),
          ),
        ],
      ),
    ),
  );
}
  }
