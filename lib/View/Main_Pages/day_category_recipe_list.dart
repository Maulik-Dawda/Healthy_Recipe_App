import 'package:flutter/material.dart';
import 'package:healthy_recipe/Controller/recipe_controller.dart';
import 'package:healthy_recipe/Theme/app_colors.dart';
import 'package:healthy_recipe/View/Main_Pages/recipe_detail_page.dart';
import 'package:healthy_recipe/Widgets/custom_text_heading.dart';
import 'package:healthy_recipe/Widgets/custom_featured_recipe_card.dart';
import 'package:provider/provider.dart';

class DayCategoryRecipeList extends StatefulWidget {
  final String id;
  final String title;

  const DayCategoryRecipeList({
    super.key,
    required this.id,
    required this.title,
  });

  @override
  State<DayCategoryRecipeList> createState() => _DayCategoryRecipeListState();
}

class _DayCategoryRecipeListState extends State<DayCategoryRecipeList> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final controller = RecipeController();
        controller.setIdAndFetch(widget.id);
        return controller;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          leading: const BackButton(),
          actions: const [Icon(Icons.search)],
        ),
        body: Consumer<RecipeController>(
          builder: (context, controller, _) {
            if (controller.catData.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            final categoryRecipes = controller.catData;
            final carouselRecipes = categoryRecipes.take(4).toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextHeading(heading: "Latest ${widget.title}", fontSize: 15),
                  const SizedBox(height: 10),

                  SizedBox(
                    height: 200,
                    child: PageView.builder(
                      itemCount: carouselRecipes.length,
                      controller: PageController(viewportFraction: 0.9),
                      onPageChanged: (index) {
                        setState(() {
                          currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        final recipe = carouselRecipes[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => RecipeDetailPage(
                                    id: recipe.id,
                                    title: recipe.title,
                                  ),
                                ),
                              );
                            },
                            child: CustomFeaturedRecipeCard(
                              imageUrl: recipe.postImage ?? '',
                              title: recipe.title ?? '',
                              time: recipe.time ?? '30 min',
                              rating: recipe.calories ?? '',
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 10),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        carouselRecipes.length,
                            (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: currentPage == index ? 12 : 8,
                          decoration: BoxDecoration(
                            color: currentPage == index ? Colors.red : Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Text("Quick and Easy", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categoryRecipes.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.85,
                    ),
                    itemBuilder: (context, index) {
                      final recipe = categoryRecipes[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RecipeDetailPage(
                                id: recipe.id,
                                title: recipe.title,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.appPrimary,
                                Color(0xff801326),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(2, 2),
                              )
                            ],
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(recipe.postImage ?? ''),
                                radius: 50,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                recipe.title ?? '',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.local_fire_department, size: 16, color: Colors.white),
                                  const SizedBox(width: 4),
                                  Text(
                                    recipe.calories ?? '',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(width: 10),
                                  const Icon(Icons.timer, size: 16, color: Colors.white),
                                  const SizedBox(width: 4),
                                  Text(
                                    recipe.time ?? '',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              )

                            ],
                          ),
                        ),
                      );
                    },
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
