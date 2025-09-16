import 'package:flutter/material.dart';
import 'package:healthy_recipe/Theme/app_colors.dart';

class CustomAuthButton extends StatelessWidget {
  final String btnName;
  final VoidCallback onPressed;

  const CustomAuthButton({
    super.key,
    required this.btnName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        SizedBox(
          height: screenHeight * 0.065,
          width: screenWidth * 0.9,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.appPrimary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(btnName, style: TextStyle(fontSize: 16)),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: screenHeight * 0.065,
            decoration: BoxDecoration(
              color: Colors.white, // Background color
              shape: BoxShape.circle,      // Circle background (or use BoxShape.rectangle)
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(
              Icons.navigate_next_sharp,
              size: 30,
              color: Colors.black,          // Icon color
            ),
          )

        ),
      ],
    );
  }
}
