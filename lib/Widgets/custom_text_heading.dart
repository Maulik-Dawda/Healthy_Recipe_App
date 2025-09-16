import 'package:flutter/material.dart';
import 'package:healthy_recipe/Theme/app_colors.dart';

class CustomTextHeading extends StatelessWidget {
  final String heading;
  final double fontSize; // <-- Added fontSize

  const CustomTextHeading({
    required this.heading,
    this.fontSize = 20, // <-- Default value
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.text,
        fontFamily: "RozhaOne-Regular",
        fontSize: fontSize, // <-- Use variable
      ),
    );
  }
}
