import 'package:flutter/material.dart';
import 'package:healthy_recipe/Controller/post_by_chef_controller.dart';
import 'package:healthy_recipe/Theme/app_colors.dart';
import 'package:healthy_recipe/Widgets/custom_recipe_listview.dart';
import 'package:provider/provider.dart';
import 'package:healthy_recipe/Widgets/custom_text_heading.dart';

class AllDishesByChef extends StatelessWidget {
  final String chefId;
  final String name;

  const AllDishesByChef({super.key, required this.chefId, required this.name});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final TextEditingController searchController = TextEditingController();

    return ChangeNotifierProvider(
      create: (_) {
        final controller = PostByChefController();
        controller.setIdAndFetch(chefId); // You must implement this
        return controller;
      },
      child: Scaffold(
        appBar: AppBar(
          title: CustomTextHeading(heading: "Dishes by $name", fontSize: 18),
          centerTitle: true,
        ),
        body: Consumer<PostByChefController>(
          builder: (context, controller, child) {
            final recipes = controller.recipeData;

            if (recipes.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                SizedBox(height: screenHeight * 0.02),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search Here",
                      hintStyle: const TextStyle(fontSize: 13),
                      filled: true,
                      fillColor: AppColors.primary,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: CustomRecipeListView(recipes: recipes),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
