import 'dart:async';
import 'package:flutter/material.dart';
import 'package:healthy_recipe/Theme/app_colors.dart';
import 'package:healthy_recipe/View/Intro/intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;

    Timer(
      Duration(seconds: 5), (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => IntroScreen()));
    }
    );

    return Scaffold(
      backgroundColor: AppColors.appPrimary,
      body: Center(
        child: Text("MealWell.in",style: TextStyle(color: AppColors.text,fontSize: screenHeight * 0.04,fontFamily: "Lobster-Regular"),),
      ),
    );
  }
}
