import 'package:flutter/material.dart';
import 'package:healthy_recipe/Controller/recipe_controller.dart';
import 'package:provider/provider.dart';
import 'package:healthy_recipe/Widgets/custom_recipe_listview.dart';

class AllRecipeList extends StatelessWidget {
  final String? id;
  final String? title;
  const AllRecipeList({super.key, required this.id, required this.title});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final controller = RecipeController();
        controller.setIdAndFetch(id!);
        return controller;
      },
      child: Scaffold(
        appBar: AppBar(title: Text(title ?? 'Category')),
        body: Consumer<RecipeController>(
          builder: (context, controller, child) {
            if (controller.catData.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomRecipeListView(recipes: controller.catData),
            );
          },
        ),
      ),
    );
  }
}
