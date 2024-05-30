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
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('https://thinksport.com.au/wp-content/uploads/2020/01/avatar-.jpg'),
                radius: 30,
              ),
              SizedBox(width: 16),
              const Text(
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
