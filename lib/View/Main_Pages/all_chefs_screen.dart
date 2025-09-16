import 'package:flutter/material.dart';
import 'package:healthy_recipe/Controller/post_by_chef_controller.dart';
import 'package:healthy_recipe/Theme/app_colors.dart';
import 'package:healthy_recipe/View/Main_Pages/chef_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:healthy_recipe/Controller/chef_detail_controller.dart';
import 'package:healthy_recipe/Widgets/custom_text_heading.dart';

class AllChefsScreen extends StatelessWidget {
  const AllChefsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final TextEditingController searchController = TextEditingController();

    return ChangeNotifierProvider(
      create: (_) {
        final controller = ChefDetailController();
        controller.fetchData();
        return controller;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const CustomTextHeading(heading: "All Chefs", fontSize: 18),
          centerTitle: true,
        ),
        body: Consumer<ChefDetailController>(
          builder: (context, controller, child) {
            if (controller.chefData.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.02,
                ),
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
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    child: GridView.builder(
                      itemCount: controller.chefData.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        final item = controller.chefData[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChangeNotifierProvider(
                                  create: (_) {
                                    final controller = PostByChefController();
                                    controller.setIdAndFetch(item.id ?? '');
                                    return controller;
                                  },
                                  child: ChefDetailScreen(
                                    name: item.name ?? "",
                                    description: item.description ?? "",
                                    image: item.image ?? '',
                                    profileUrl: item.profileUrl ?? '',
                                    igUrl: item.instagramUrl ?? '',
                                    id: item.id ?? '',
                                  ),
                                ),
                              ),
                            );
                          },

                          child: Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    item.image ?? '',
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                item.name ?? '',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
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
