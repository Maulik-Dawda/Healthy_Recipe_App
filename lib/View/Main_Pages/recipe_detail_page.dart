import 'package:flutter/material.dart';
import 'package:healthy_recipe/Controller/recipe_detail_controller.dart';
import 'package:healthy_recipe/Widgets/custom_recipe_detail.dart';
import 'package:provider/provider.dart';

class RecipeDetailPage extends StatelessWidget {
  final String? id;
  final String? title;

  const RecipeDetailPage({super.key, required this.id, required this.title});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final controller = RecipeDetailController();
        controller.setIdAndFetch(id!); // you’ll create this method
        return controller;
      },
      child: SafeArea(
        child: Scaffold(
          body: Consumer<RecipeDetailController>(
            builder: (context, controller, child) {
              if (controller.recipeData.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView.separated(
                itemCount: controller.recipeData.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final item = controller.recipeData[index];
                  return CustomRecipeDetail(
                    imageUrl: item.postImage ?? "",
                    title: title ?? "",
                    ingredients: item.ingredients ?? "",
                    methods: item.methods ?? "",
                    time: item.time ?? "",
                    about: item.about ?? "",
                    calories: item.calories ?? "",
                    chef: item.chefName ?? "",
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
