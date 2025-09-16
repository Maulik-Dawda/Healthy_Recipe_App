import 'package:flutter/material.dart';
import 'package:healthy_recipe/Controller/all_recipe_controller.dart';
import 'package:healthy_recipe/Controller/category_controller.dart';
import 'package:healthy_recipe/Controller/chef_detail_controller.dart';
import 'package:healthy_recipe/Controller/post_by_chef_controller.dart';
import 'package:healthy_recipe/Theme/app_colors.dart';
import 'package:healthy_recipe/View/Main_Pages/all_chefs_screen.dart';
import 'package:healthy_recipe/View/Main_Pages/all_recipe_list.dart';
import 'package:healthy_recipe/View/Main_Pages/categroy_list_page.dart';
import 'package:healthy_recipe/View/Main_Pages/chef_detail_screen.dart';
import 'package:healthy_recipe/View/Main_Pages/day_category_recipe_list.dart';
import 'package:healthy_recipe/View/Main_Pages/recipe_detail_page.dart';
import 'package:healthy_recipe/View/Main_Pages/recipe_list_page.dart';
import 'package:healthy_recipe/Widgets/custom_category_list_view_container.dart';
import 'package:healthy_recipe/Widgets/custom_chef_circle_card.dart';
import 'package:healthy_recipe/Widgets/custom_day_category_container.dart';
import 'package:healthy_recipe/Widgets/custom_recipe_card.dart';
import 'package:healthy_recipe/Widgets/custom_text_button.dart';
import 'package:healthy_recipe/Widgets/custom_text_heading.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CategoryController>().fetchData();
    context.read<ChefDetailController>().fetchData();
    context.read<AllRecipeController>().fetchRecipeData();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final categoryController = context.watch<CategoryController>();
    final chefDetailController = context.watch<ChefDetailController>();
    final allRecipeController = context.watch<AllRecipeController>() ;
    final recipeList = allRecipeController.recipeData;
    final randomRecipes = recipeList.length >= 10
        ? (recipeList.toList()..shuffle()).take(10).toList()
        : recipeList;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 40, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: screenHeight * 0.075,
                  ),
                  const Icon(Icons.notifications_none, size: 40),
                ],
              ),
              const SizedBox(height: 15),

              // Search Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: screenHeight * 0.05,
                    width: screenWidth * 0.8,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "What would you like to cook?",
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
                  const Icon(Icons.tune, size: 40),
                ],
              ),
              const SizedBox(height: 20),

              const Image(
                image: AssetImage('assets/images/line_with_heading_category.png'),
              ),
              const SizedBox(height: 20),

              // Day Categories
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categoryController.catData
                      .where((item) {
                    final name = item.catName?.toLowerCase().trim();
                    return name == "breakfast" || name == "lunch" || name == "dinner" || name == "dessert";
                  })
                      .map((item) => Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: CustomDayCategoryContainer(
                      text: item.catName,
                      image: item.catImage, onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DayCategoryRecipeList(id: item.id ?? "", title: item.catName ?? "")));
                    },
                    ),
                  ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),

              // More Categories
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomTextHeading(
                    heading: "More Category",
                    fontSize: 15,
                  ),
                  CustomTextButton(
                    text: "See More",
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryListPage()));
                    },
                    color: AppColors.appPrimary,
                  ),
                ],
              ),
              const SizedBox(height: 10),

              categoryController.catData.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                height: 120,
                child: Builder(
                  builder: (context) {
                    final filteredList = categoryController.catData
                        .where((item) {
                      final name = item.catName?.toLowerCase().trim();
                      return !(name == "breakfast" || name == "lunch" || name == "dinner" || name == "dessert");
                    })
                        .take(5)
                        .toList();

                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: filteredList.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 15),
                      itemBuilder: (context, index) {
                        final item = filteredList[index];
                        return CategoryCard(
                          imageUrl: item.catImage ?? '',
                          title: item.catName ?? '',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllRecipeList(id: item.id, title: item.catName),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Top Chef
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomTextHeading(
                    heading: "Top Chef",
                    fontSize: 15,
                  ),
                  CustomTextButton(
                    text: "See More",
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AllChefsScreen()));
                    },
                    color: AppColors.appPrimary,
                  ),
                ],
              ),
              const SizedBox(height: 10),

              chefDetailController.chefData.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                height: 140,
                child: Builder(
                  builder: (context) {
                    final chefList = chefDetailController.chefData.take(6).toList();

                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: chefList.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 15),
                      itemBuilder: (context, index) {
                        final chef = chefList[index];
                        return CustomChefCircleCard(
                          image: chef.image ?? '',
                          name: chef.name ?? '',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                  create: (_) {
                                    final controller = PostByChefController();
                                    controller.setIdAndFetch(chef.id ?? '');
                                    return controller;
                                  },
                                  child: ChefDetailScreen(
                                    name: chef.name ?? '',
                                    description: chef.description ?? '',
                                    image: chef.image ?? '',
                                    profileUrl: chef.profileUrl ?? '',
                                    igUrl: chef.instagramUrl ?? '',
                                    id: chef.id ?? '',
                                  ),
                                ),
                              ),
                            );

                          },
                        );
                      },

                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomTextHeading(
                    heading: "Recommended",
                    fontSize: 15,
                  ),
                  CustomTextButton(
                    text: "See More",
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RecipeListPage()));
                    },
                    color: AppColors.appPrimary,
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.3,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: randomRecipes.length,
                  itemBuilder: (context, index) {
                    final recipe = randomRecipes[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SizedBox(
                        width: 180,
                        child: CustomRecipeCard(
                          imageUrl: recipe.postImage,
                          title: recipe.title,
                          time: recipe.time,
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
                        ),
                      ),
                    );
                  },
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
