import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:healthy_recipe/Theme/app_colors.dart';
import 'package:healthy_recipe/View/Authentication_Screen/login_screen.dart';
import 'package:healthy_recipe/View/Select_Category/select_category_screen.dart';
import 'package:healthy_recipe/Widgets/custom_auth_button.dart';
import 'package:healthy_recipe/Widgets/custom_text_button.dart';
import 'package:healthy_recipe/Widgets/custom_text_form_feild.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.43,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: screenHeight * 0.3,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: AppColors.appPrimary,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 85,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/login_food.png',
                        height: screenHeight * 0.3,
                        width: screenWidth * 0.6,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: screenWidth * 0.9,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomFromTextField(
                      controller: emailController,
                      leadingIcon: Icons.chat_bubble_outline,
                      nameText: "Your Email",
                      hintText: "Enter Your Email",
                      validator: ValidationBuilder().email().maxLength(100).build(),
                    ),
                    SizedBox(height: screenHeight * 0.025),
                    CustomFromTextField(
                      controller: passwordController,
                      leadingIcon: Icons.lock_open,
                      nameText: "Your Password",
                      hintText: "Enter Your Password",
                      trailingIcon: isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      onTrailingIconPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      isPassword: !isPasswordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) return "Please enter password";
                        if (value.length < 8) return "Minimum 8 characters required";
                        return null;
                      },
                    ),
                    SizedBox(height: screenHeight * 0.025),
                    CustomFromTextField(
                      controller: confirmPasswordController,
                      leadingIcon: Icons.lock_open,
                      nameText: "Confirm Password",
                      hintText: "Confirm Your Password",
                      trailingIcon: isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      onTrailingIconPressed: () {
                        setState(() {
                          isConfirmPasswordVisible = !isConfirmPasswordVisible;
                        });
                      },
                      isPassword: !isConfirmPasswordVisible,
                      validator: (value) {
                        if (value != passwordController.text) return "Passwords do not match";
                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: CustomTextButton(
                        text: "Remember Me",
                        onPressed: () {},
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.025),
                    CustomAuthButton(
                      btnName: "Register",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const SelectCategoryScreen()),
                          );
                        }
                      },
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?", style: TextStyle(fontSize: 13)),
                        CustomTextButton(
                          text: 'Log in!',
                          color: Colors.red,
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => LoginScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
