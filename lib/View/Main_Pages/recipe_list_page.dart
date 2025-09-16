import 'package:flutter/material.dart';
import 'package:healthy_recipe/Controller/all_recipe_controller.dart';
import 'package:healthy_recipe/Theme/app_colors.dart';
import 'package:healthy_recipe/View/Main_Pages/recipe_detail_page.dart';
import 'package:provider/provider.dart';
import 'package:healthy_recipe/Widgets/custom_text_heading.dart';

class RecipeListPage extends StatelessWidget {
  const RecipeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return ChangeNotifierProvider(
      create: (_) {
        final controller = AllRecipeController();
        controller.fetchRecipeData();
        return controller;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const CustomTextHeading(heading: "Recommended", fontSize: 18),
          centerTitle: true,
        ),
        body: Consumer<AllRecipeController>(
          builder: (context, controller, child) {
            if (controller.recipeData.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    TextField(
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
                    const SizedBox(height: 20),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.recipeData.length,
                      itemBuilder: (context, index) {
                        final item = controller.recipeData[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => RecipeDetailPage(
                                      id: item.id,
                                      title: item.title,
                                    ),
                              ),
                            );
                          },
                          child: Card(
                            margin: const EdgeInsets.only(bottom: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      ),
                                      child: Image.network(
                                        item.postImage ?? '',
                                        width: double.infinity,
                                        height: 180,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (_, __, ___) => const Icon(
                                              Icons.image_not_supported,
                                            ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.white,
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.bookmark_border,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          CircleAvatar(
                                            backgroundColor: Colors.white,
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.share,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title ?? '',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.access_time,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(item.time ?? 'N/A'),
                                          const Spacer(),
                                          Text(
                                            item.calories ?? '5.0',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Icon(
                                            Icons.local_fire_department,
                                            size: 16,
                                            color: Colors.orange,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
