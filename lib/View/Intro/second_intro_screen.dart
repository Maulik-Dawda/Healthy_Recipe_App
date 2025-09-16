import 'package:flutter/material.dart';
import 'package:healthy_recipe/Theme/app_colors.dart';
import 'package:healthy_recipe/View/Authentication_Screen/login_screen.dart';

class SecondIntroScreen extends StatelessWidget {
  const SecondIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(
                'assets/images/food_gallery_second_intro_screen.png',
              ),
              height: screenHeight * 0.6,
              width: double.infinity,
            ),
            Image(
              image: AssetImage('assets/images/logo.png'),
              height: screenHeight * 0.07,
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              'Your favourite source for best multiple foods recipe.....',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff666666),
                fontSize: 17,
                fontFamily: 'RozhaOne-Regular',
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            SizedBox(
              height: screenHeight * 0.05,
              width: screenWidth * 0.7,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.appPrimary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text("Continue", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
