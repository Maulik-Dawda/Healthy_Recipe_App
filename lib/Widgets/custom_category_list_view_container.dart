import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onPressed;

  const CategoryCard({super.key, required this.imageUrl, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
              imageUrl,
              width: 150,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(fontSize: 14, color: Colors.grey[800]),
        ),
      ],
    );
  }
}
