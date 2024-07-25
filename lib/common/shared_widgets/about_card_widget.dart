import 'package:flutter/material.dart';

import '../../components/app_text_styles.dart';

class AboutCardWidget extends StatelessWidget {
  const AboutCardWidget({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, 'about');
        },
        child: SizedBox(
          width: double.infinity, // Make the card width match its parent
          height: 60, // Set the card height
          child: const Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.info_outline),
                Text(
                  'Tentang Kami',
                  style: AppTextStyle.heading5Bold,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
