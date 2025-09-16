import 'package:flutter/material.dart';

class CustomFeaturedRecipeCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String time;
  final String rating;

  const CustomFeaturedRecipeCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.time,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            imageUrl,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.error),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.pink[50],
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(time, style: const TextStyle(fontSize: 12)),
                    const SizedBox(width: 12),
                    const Icon(Icons.star, size: 16, color: Colors.red),
                    const SizedBox(width: 4),
                    Text(rating, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
