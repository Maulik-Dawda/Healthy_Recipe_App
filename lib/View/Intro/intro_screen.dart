import 'package:flutter/material.dart';
import 'package:healthy_recipe/Theme/app_colors.dart';
import 'package:healthy_recipe/View/Intro/second_intro_screen.dart';
import 'package:healthy_recipe/Widgets/custom_text_heading.dart';


class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: AssetImage('assets/images/intro.png'),
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Opacity(
            opacity: 0.5,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: AppColors.background,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(left: 20.0, top: 30.0, right: 20),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              height: screenHeight * 0.22,
              width: double.infinity,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: CustomTextHeading(heading: 'Lets Cook Food')
                  ),
                  SizedBox(height: screenHeight * 0.007),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '"Discover new flavors, cook with confidence, and bring your kitchen to life with our app!"',
                      style: TextStyle(
                        color: Color(0xff666666),
                        fontSize: screenHeight * 0.0125,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.05,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SecondIntroScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.appPrimary,
                          foregroundColor: AppColors.background,
                        elevation: 4,
                      ),
                      child: Text(
                        'Start Cooking'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
