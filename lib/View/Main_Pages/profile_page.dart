import 'package:flutter/material.dart';
import 'package:healthy_recipe/Theme/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/profile_avatar.png'), // Use your asset
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Full Name",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.edit, size: 16, color: Colors.white),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Full Email Address",
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
              
              buildSidebarItem(Icons.home, "Home"),
              buildSidebarItem(Icons.bookmark_border, "Save"),
              buildSidebarItem(Icons.calendar_today_outlined, "See Meal Planner"),
              buildSidebarItem(Icons.search, "Ingredient-Based Search"),
              buildSidebarItem(Icons.language, "Language"),
              buildSidebarItem(Icons.person_outline, "Following List"),
              buildSidebarItem(Icons.list_alt, "Shopping List"),
              buildSidebarItem(Icons.settings, "Settings"),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSidebarItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(width: 15),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
