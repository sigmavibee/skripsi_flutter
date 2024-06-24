import 'package:flutter/material.dart';
import 'package:stunting_project/components/app_text_styles.dart';


class InputLayout extends StatelessWidget {
  final String label;
  final StatefulWidget inputField;

  const InputLayout(
    this.label,
    this.inputField, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.body2Medium.copyWith(
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          child: inputField,
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

class InputLayoutCus extends StatelessWidget {
  final String label;
  final StatefulWidget inputField;

  const InputLayoutCus(
    this.label,
    this.inputField, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.body3Regular.copyWith(
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          child: inputField,
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

InputDecoration customInputDecoration(String hintText, {Widget? suffixIcon}) {
  return InputDecoration(
      hintText: hintText,
      suffixIcon: suffixIcon,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)));
}
