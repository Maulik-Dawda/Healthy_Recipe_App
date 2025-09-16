import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthy_recipe/Controller/category_controller.dart';
import 'package:healthy_recipe/Theme/app_colors.dart';
import 'package:healthy_recipe/View/Main_Pages/day_category_recipe_list.dart';
import 'package:healthy_recipe/Widgets/custom_text_heading.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return ChangeNotifierProvider(
      create: (_) {
        final controller = CategoryController();
        controller.fetchData();
        return controller;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const CustomTextHeading(heading: "Categories", fontSize: 18),
          centerTitle: true,
        ),
        body: Consumer<CategoryController>(
          builder: (context, controller, child) {
            if (controller.catData.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            // Filter out unwanted categories
            final filteredCategories = controller.catData.where((cat) {
              final name = (cat.catName ?? '').toLowerCase();
              return name != 'breakfast' &&
                  name != 'lunch' &&
                  name != 'dinner' &&
                  name != 'dessert';
            }).toList();

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  children: [
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search Categories",
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
                      itemCount: filteredCategories.length,
                      itemBuilder: (context, index) {
                        final item = filteredCategories[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DayCategoryRecipeList(
                                  id: item.id ?? '',
                                  title: item.catName ?? 'Category',
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
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                  ),
                                  child: Image.network(
                                    item.catImage ?? '',
                                    width: 120,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    item.catName ?? '',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.arrow_forward_ios, size: 16),
                                const SizedBox(width: 10),
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
