import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final VoidCallback onTap;
  final String? username;
  final String? avatarUrl;

  const ProfileCard({
    Key? key,
    required this.onTap,
    this.username,
    this.avatarUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: avatarUrl != null && avatarUrl!.isNotEmpty
                    ? NetworkImage(avatarUrl!)
                    : AssetImage('assets/avatar.jpg') as ImageProvider<Object>,
                radius: 30,
              ),
              const SizedBox(width: 16),
              Text(
                username ?? 'Name not fetched',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

