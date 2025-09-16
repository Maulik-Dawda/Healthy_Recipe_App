import 'package:flutter/material.dart';
import 'package:healthy_recipe/Controller/post_by_chef_controller.dart';
import 'package:healthy_recipe/Theme/app_colors.dart';
import 'package:healthy_recipe/View/Main_Pages/all_dishes_by_chef.dart';
import 'package:healthy_recipe/View/Main_Pages/recipe_detail_page.dart';
import 'package:healthy_recipe/Widgets/custom_text_button.dart';
import 'package:healthy_recipe/Widgets/custom_text_heading.dart';
import 'package:provider/provider.dart';

class ChefDetailScreen extends StatelessWidget {
  final String id;
  final String name;
  final String image;
  final String description;
  final String profileUrl;
  final String igUrl;

  const ChefDetailScreen({
    super.key,
    required this.name,
    required this.description,
    required this.image,
    required this.profileUrl,
    required this.igUrl,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: CustomTextHeading(heading: name),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.share_outlined)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.03),
              CircleAvatar(radius: 60, backgroundImage: NetworkImage(image)),
              Text(name, style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
              Text(description, style: TextStyle(fontSize: 12, color: Colors.grey), textAlign: TextAlign.center),
              Text(profileUrl, style: TextStyle(fontSize: 12, color: Colors.grey), textAlign: TextAlign.center),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: screenHeight * 0.05,
                    width: screenWidth * 0.3,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.appPrimary,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Follow"),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt, size: 40)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.near_me, size: 40)),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomTextHeading(heading: "Famous Dishes", fontSize: 15),
                  CustomTextButton(
                    text: "See More",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllDishesByChef(chefId: id, name: name,),
                        ),
                      );
                    },
                    color: AppColors.appPrimary,
                  ),
                ],
              ),
              Consumer<PostByChefController>(
                builder: (context, controller, _) {
                  final recipes = controller.recipeData;
                  if (recipes.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: recipes.length > 6 ? 6 : recipes.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 3 / 4,
                    ),
                    itemBuilder: (context, index) {
                      final recipe = recipes[index];
                      return InkWell(
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetailPage(id: recipe.id, title: recipe.title)));},
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                                child: Image.network(
                                  recipe.postImage ?? '',
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: screenHeight * 0.06,
                                      child: Center(
                                        child: Text(
                                          recipe.title ?? '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(recipe.time ?? ""),
                                              Text(" mins"),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Center(child: Text("Easy")),
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
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
