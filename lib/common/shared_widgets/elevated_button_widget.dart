import 'package:flutter/material.dart';

class ElevatedButton1 extends StatelessWidget {
  final VoidCallback? onPressed;
  final String labelText;
  final Color labelColor;
  final Color backgroundColor;
  final Color disableBackgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;

  const ElevatedButton1({
    super.key,
    required this.onPressed,
    required this.labelText,
    this.backgroundColor = Colors.black,
    this.disableBackgroundColor = const Color.fromARGB(255, 93, 87, 37),
    this.labelColor = Colors.white,
    this.borderRadius,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            disabledBackgroundColor: disableBackgroundColor,
            backgroundColor: backgroundColor,
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8.0))),
        child: Text(
          labelText,
          textAlign: TextAlign.center,
          //style: AppTextStyle.body2Bold.copyWith(color: labelColor),
        ),
      ),
    );
  }
}
