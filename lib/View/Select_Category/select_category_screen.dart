import 'package:flutter/material.dart';
import 'package:healthy_recipe/Controller/select_category_controller.dart';
import 'package:healthy_recipe/Theme/app_colors.dart';
import 'package:healthy_recipe/View/Select_Category/select_chef_screen.dart';
import 'package:healthy_recipe/Widgets/custom_auth_button.dart';
import 'package:healthy_recipe/Widgets/custom_text_button.dart';
import 'package:healthy_recipe/Widgets/custom_text_heading.dart';
import 'package:provider/provider.dart';

class SelectCategoryScreen extends StatelessWidget {
  const SelectCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (_) {
        final controller = SelectCategoryController();
        controller.getCatName();
        return controller;
      },
      child: Scaffold(
        body: Consumer<SelectCategoryController>(
          builder: (context, categoryController, _) {
            final categories = categoryController.catName;
            final selectedIndexes = categoryController.selectedIndexes;

            if (categories == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.1),
                  const CustomTextHeading(
                    heading: "Do you have any dietary preference ?",
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  const Text(
                    'Select your dietary preference for better recommendation or you can skip it.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: screenHeight * 0.08),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: List.generate(categories.length, (index) {
                      final item = categories[index];
                      final name = item['cat_name'] ?? 'Unknown';
                      final isSelected = selectedIndexes.contains(index);

                      return GestureDetector(
                        onTap: () => categoryController.toggleSelection(index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.appPrimary
                                : AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: screenHeight * 0.06),
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: CustomAuthButton(
                      btnName: "Continue",
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SelectChefScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  CustomTextButton(
                    text: "Skip",
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SelectChefScreen(),
                        ),
                      );
                    },
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
