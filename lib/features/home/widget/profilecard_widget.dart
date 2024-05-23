import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final VoidCallback onTap;

  const ProfileCard({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/avatar.jpg'),
                radius: 30,
              ),
              SizedBox(width: 16),
              Text(
                'Charles Leclerc',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
