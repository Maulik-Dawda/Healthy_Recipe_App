import 'package:flutter/material.dart';
import 'package:healthy_recipe/Theme/app_colors.dart';

class CustomRecipeDetail extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String ingredients;
  final String methods;
  final String time;
  final String about;
  final String calories;
  final String chef;

  const CustomRecipeDetail({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.ingredients,
    required this.methods,
    required this.time,
    required this.about,
    required this.calories,
    required this.chef,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: screenHeight * 0.3,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Column(
                  spacing: 5,
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
                    const SizedBox(height: 8),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.star,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: screenHeight * 0.2,
                left: screenWidth * 0.1,
                child: Opacity(
                  opacity: 0.98,
                  child: Container(
                    height: screenHeight * 0.25,
                    width: screenWidth * 0.8,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(title, style: TextStyle(fontSize: 16)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.star, color: AppColors.appPrimary),
                                Text("2.0"),
                              ],
                            ),
                            CircleAvatar(
                              backgroundColor: AppColors.secondary,
                              radius: 20,
                              child: Icon(
                                Icons.change_history,
                                color: AppColors.appPrimary,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 1,
                          thickness: 2,
                          indent: 15,
                          endIndent: 15,
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.access_time_rounded),
                                Text("$time mins"),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(Icons.person_2_outlined),
                                Text(chef),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.16),
          DefaultTabController(
            length: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                  labelColor: AppColors.appPrimary,
                  unselectedLabelColor: Colors.black,
                  indicatorColor: AppColors.appPrimary,
                  tabs: [
                    Tab(text: 'Ingredients'),
                    Tab(text: 'Methods'),
                    Tab(text: 'About'),
                  ],
                ),
                SizedBox(height: screenHeight * 0.010),
                Container(
                  height: screenHeight * 0.45,
                  color: AppColors.appPrimary,
                  child: TabBarView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 20,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                ingredients.split(',').map((ingredient) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10.0,
                                      horizontal: 8.0,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "•  ${ingredient.trim()}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                methods
                                    .split(RegExp(r'Step \d+:'))
                                    .where((step) => step.trim().isNotEmpty)
                                    .toList()
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                      final index = entry.key + 1;
                                      final stepText = entry.value.trim();
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10.0,
                                          horizontal: 10.0,
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Step $index',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              stepText,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    })
                                    .toList(),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 20,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(),
                                child: Column(
                                  spacing: 20,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "About",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      about,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        height: screenHeight * 0.05,
                                       width: screenWidth * 0.5,
                                       decoration: BoxDecoration(
                                         color: Colors.white,
                                         borderRadius: BorderRadius.all(Radius.circular(10))
                                       ),
                                        child: Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              height: screenHeight * 0.05,
                                              width: screenWidth * 0.15,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black),
                                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                              ),
                                              child: Text(calories),
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.1,
                                            ) ,
                                            Text("Calories")
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
