import 'package:flutter/material.dart';
import 'package:healthy_recipe/Controller/chef_detail_controller.dart';
import 'package:healthy_recipe/Modal/chef_detail_model.dart';
import 'package:healthy_recipe/Theme/app_colors.dart';
import 'package:healthy_recipe/View/Main_Pages/dashboard.dart';
import 'package:healthy_recipe/Widgets/custom_auth_button.dart';
import 'package:healthy_recipe/Widgets/custom_text_heading.dart';
import 'package:healthy_recipe/Widgets/custom_text_button.dart';
import 'package:provider/provider.dart';

class SelectChefScreen extends StatefulWidget {
  const SelectChefScreen({super.key});

  @override
  State<SelectChefScreen> createState() => _SelectChefScreenState();
}

class _SelectChefScreenState extends State<SelectChefScreen> {
  final Set<String> followedChefIds = {};

  @override
  void initState() {
    super.initState();
    final controller = Provider.of<ChefDetailController>(context, listen: false);
    if (controller.chefData.isEmpty) {
      controller.fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Consumer<ChefDetailController>(
        builder: (context, controller, _) {
          final List<ChefDetailModel> chefs = controller.chefData.take(4).toList();

          return SafeArea(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.07),
                const CustomTextHeading(
                  heading: "You want to \n Follow \n Your Favourite Chefs",
                ),
                SizedBox(height: screenHeight * 0.025),
                const Icon(Icons.mail_outline),
                SizedBox(height: screenHeight * 0.04),

                // Chef Grid
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: chefs.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.85,
                    ),
                    itemBuilder: (context, index) {
                      final chef = chefs[index];
                      final isFollowing = followedChefIds.contains(chef.id);

                      return Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(chef.image ?? ''),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (isFollowing) {
                                  followedChefIds.remove(chef.id);
                                } else {
                                  followedChefIds.add(chef.id!);
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isFollowing
                                  ? AppColors.appPrimary
                                  : AppColors.primary,
                              foregroundColor: isFollowing ? Colors.white : Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                            ),
                            child: Text(isFollowing ? "Following" : "Follow"),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                // Continue and Skip Buttons
                SizedBox(height: screenHeight * 0.03),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: CustomAuthButton(
                    btnName: "Continue",
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Dashboard(), // Replace with next screen
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),
                CustomTextButton(
                  text: "Skip",
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Dashboard(), // Replace with next screen
                      ),
                    );
                  },
                  color: Colors.black,
                  fontSize: 15,
                ),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          );
        },
      ),
    );
  }
}
