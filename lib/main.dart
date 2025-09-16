import 'package:flutter/material.dart';
import 'package:healthy_recipe/Controller/all_recipe_controller.dart';
import 'package:healthy_recipe/Controller/category_controller.dart';
import 'package:healthy_recipe/Controller/chef_detail_controller.dart';
import 'package:healthy_recipe/Controller/post_by_chef_controller.dart';
import 'package:healthy_recipe/Controller/recipe_controller.dart';
import 'package:healthy_recipe/View/Intro/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryController()),
        ChangeNotifierProvider(create: (_) => RecipeController()),
        ChangeNotifierProvider(create: (_) => ChefDetailController()),
        ChangeNotifierProvider(create: (_) => PostByChefController()),
        ChangeNotifierProvider(create: (_) => AllRecipeController())
        
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthy Recipe',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
