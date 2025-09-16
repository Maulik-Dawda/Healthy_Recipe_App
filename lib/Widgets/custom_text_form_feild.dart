import 'package:flutter/material.dart';

class CustomFromTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData leadingIcon;
  final String nameText;
  final String hintText;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingIconPressed;
  final String? Function(String?)? validator;
  final bool isPassword;

  const CustomFromTextField({
    Key? key,
    required this.controller,
    required this.leadingIcon,
    required this.nameText,
    required this.hintText,
    this.trailingIcon,
    this.onTrailingIconPressed,
    this.validator,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(nameText, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(leadingIcon),
            suffixIcon: trailingIcon != null
                ? IconButton(
              icon: Icon(trailingIcon),
              onPressed: onTrailingIconPressed,
            )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
