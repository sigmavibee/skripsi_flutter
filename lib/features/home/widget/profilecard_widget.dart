import 'package:flutter/material.dart';
import 'package:stunting_project/components/app_text_styles.dart';
import 'package:stunting_project/components/colors.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), 
      child: Container(
        height: 100  ,
        decoration: BoxDecoration(border: Border.all(color: successColor),borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(16),
        child: const Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/avatar.jpg'),
              radius: 30,
            ),
            SizedBox(width: 16),
            Text(
              'Charles Leclerc',
              style: AppTextStyle.body2Bold,
            ),
          ],
        ),
      ),
    );
  }
}
