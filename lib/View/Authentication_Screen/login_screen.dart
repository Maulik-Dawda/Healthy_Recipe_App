import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:healthy_recipe/Theme/app_colors.dart';
import 'package:healthy_recipe/View/Authentication_Screen/register_screen.dart';
import 'package:healthy_recipe/View/Select_Category/select_category_screen.dart';
import 'package:healthy_recipe/Widgets/custom_auth_button.dart';
import 'package:healthy_recipe/Widgets/custom_text_button.dart';
import 'package:healthy_recipe/Widgets/custom_text_form_feild.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isVisible = false;

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
              height: screenHeight * 0.5,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: screenHeight * 0.3,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: AppColors.appPrimary,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 120,
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

            Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Column(
                  children: [
                    CustomFromTextField(
                      controller: emailController,
                      leadingIcon: Icons.email,
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
                      trailingIcon: isVisible ? Icons.visibility : Icons.visibility_off,
                      isPassword: !isVisible,
                      onTrailingIconPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) return "Please enter password";
                        if (value.length < 8) return "At least 8 characters required";
                        return null;
                      },
                    ),

                    Align(
                      alignment: Alignment.topLeft,
                      child: CustomTextButton(
                        text: "Forgot Password ?",
                        onPressed: () {},
                        color: Colors.red,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.025),

                    CustomAuthButton(
                      btnName: "Log In",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const SelectCategoryScreen()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please correct the errors")),
                          );
                        }
                      },
                    ),

                    SizedBox(height: screenHeight * 0.05),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?", style: TextStyle(fontSize: 13)),
                        SizedBox(width: screenWidth * 0.02),
                        CustomTextButton(
                          text: 'Register!',
                          color: Colors.red,
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => RegisterScreen()),
                            );
                          },
                        )
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
