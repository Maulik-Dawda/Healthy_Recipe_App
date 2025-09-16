import 'package:flutter/material.dart';

class CustomChefCircleCard extends StatelessWidget {
  final String image;
  final String name;
  final VoidCallback onPressed;

  const CustomChefCircleCard({super.key, required this.onPressed, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          child: CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(image),
          )
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(fontSize: 14, color: Colors.grey[800]),
        ),
      ],
    );
  }
}



// ClipRRect(
// borderRadius: BorderRadius.circular(30),
// child: Image.network(
// image,
// width: 80,
// height: 80,
// fit: BoxFit.cover,
// ),
// ),
