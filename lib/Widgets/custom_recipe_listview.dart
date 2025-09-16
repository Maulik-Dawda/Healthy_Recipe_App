import 'package:flutter/material.dart';
import 'package:healthy_recipe/Modal/recipe_detail_model.dart';
import 'package:healthy_recipe/View/Main_Pages/recipe_detail_page.dart';
import 'package:healthy_recipe/Widgets/custom_recipe_card.dart';

class CustomRecipeListView extends StatelessWidget {
  final List<RecipeDetailModel> recipes;

  const CustomRecipeListView({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: recipes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 3 / 4,
      ),
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return CustomRecipeCard(
          imageUrl: recipe.postImage,
          title: recipe.title,
          time: recipe.time,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    RecipeDetailPage(id: recipe.id, title: recipe.title),
              ),
            );
          },
        );
      },
    );
  }
}
