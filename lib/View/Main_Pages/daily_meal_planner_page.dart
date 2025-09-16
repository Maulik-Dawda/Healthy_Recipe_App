import 'package:flutter/material.dart';
import 'package:healthy_recipe/Theme/app_colors.dart';
import 'package:healthy_recipe/View/Main_Pages/dashboard.dart';
import 'package:intl/intl.dart';

class DailyMealPlannerPage extends StatelessWidget {
  DailyMealPlannerPage({super.key});

  final DateTime currentDate = DateTime.now();
  final int firstDayOffset = DateTime(DateTime.now().year, DateTime.now().month, 1).weekday % 7;

  List<Widget> _buildCalendarDays() {
    final daysInMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;
    final List<Widget> dayWidgets = [];

    // Day Labels
    const dayLabels = ["M", "T", "W", "T", "F", "S", "S"];
    dayWidgets.addAll(dayLabels
        .map((d) => Center(
      child: Text(d,
          style: const TextStyle(fontWeight: FontWeight.bold)),
    ))
        .toList());

    // Padding for start of the month
    for (int i = 0; i < firstDayOffset; i++) {
      dayWidgets.add(const SizedBox());
    }

    // Days of month
    for (int i = 1; i <= daysInMonth; i++) {
      dayWidgets.add(
        Center(
          child: Text(
            i.toString(),
            style: const TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    return dayWidgets;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));}, icon: Icon(Icons.arrow_back_ios_new_outlined)),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Make Your Plan For\nDaily Meal",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _buildTabButton("Calendar"),
                _buildTabButton("Breakfast"),
                _buildTabButton("Lunch"),
                _buildTabButton("Dinner"),
              ],
            ),
            const SizedBox(height: 20),

            // Month title
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                DateFormat.yMMM().format(currentDate), // e.g., Jul 2025
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),

            // Calendar Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 7,
                children: _buildCalendarDays(),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _actionButton("Cancel", Colors.white, AppColors.appPrimary),
                _actionButton("Continue", AppColors.appPrimary, Colors.white),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.amber[800],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _actionButton(String label, Color bgColor, Color textColor) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        side: BorderSide(color: textColor),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(label),
    );
  }
}
