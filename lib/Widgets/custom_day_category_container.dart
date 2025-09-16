import 'package:flutter/material.dart';
import 'package:healthy_recipe/Theme/app_colors.dart';

class CustomDayCategoryContainer extends StatelessWidget {
  final String? text;
  final String? image;
  final VoidCallback onTap;

  const CustomDayCategoryContainer({super.key, required this.text, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            height: screenHeight * 0.12,
            width: screenWidth * 0.35,
            margin: const EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.appPrimary,
                  Color(0xff801326),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  text!,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 35,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(image!),
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
