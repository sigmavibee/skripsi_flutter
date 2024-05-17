import 'package:flutter/material.dart';
import 'package:stunting_project/components/colors.dart';

class AppTextStyle {
  // heading
  static const TextStyle heading3Bold = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    height: 38 / 28,
  );
  static const TextStyle heading4Bold = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    height: 34 / 24,
  );
  static const TextStyle heading5Bold = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    height: 26 / 20,
  );

  // body
  static const TextStyle body2Bold = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      height: 24 / 16);
  static const TextStyle body2SemiBold = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      height: 24 / 16);
  static const TextStyle body2Medium = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      height: 24 / 16);
  static const TextStyle body2Regular = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      height: 24 / 16);
  static const TextStyle body3Medium = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      height: 20 / 14);
  static const TextStyle body3SemiBold = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      height: 20 / 14);
  static const TextStyle body3Bold = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      height: 20 / 14);
  static const TextStyle body4SemiBold = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
      height: 18 / 12);
  static const TextStyle body4Bold = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
      height: 18 / 12);
  static const TextStyle body4Medium = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      height: 18 / 12);
  static const TextStyle body4Regular = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      height: 18 / 12);

  // paragraph
  static const TextStyle paragraphRegular = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      height: 20 / 14);

  static const TextStyle paragraphMedium = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      height: 24 / 16);
}

var buttonStyle = ElevatedButton.styleFrom(
  padding: const EdgeInsets.symmetric(vertical: 15),
  backgroundColor: primaryColor,
);
