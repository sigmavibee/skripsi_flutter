import 'package:flutter/material.dart';

import '../../components/app_text_styles.dart';
import '../../components/colors.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String appBarTitle;

  const CustomAppBarWidget({required this.appBarTitle, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: successColor,
      title: Text(appBarTitle, style: AppTextStyle.heading4Bold),
      automaticallyImplyLeading: false,
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/logo_puskesmas.png',
            width: 20,
            height: 25,
            fit: BoxFit.contain,
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/logo_puskesmas.png'),
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomAppBarWithBackButton extends StatelessWidget
    implements PreferredSizeWidget {
  final String appBarTitle;

  const CustomAppBarWithBackButton({required this.appBarTitle, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: successColor,
      title: Text(appBarTitle, style: AppTextStyle.heading4Bold),
      automaticallyImplyLeading: true, // Add this to show the back button
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/logo_puskesmas.png',
            width: 20,
            height: 25,
            fit: BoxFit.contain,
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/logo_puskesmas.png'),
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
