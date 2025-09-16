import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:healthy_recipe/Modal/recipe_detail_model.dart';
import 'package:http/http.dart' as http;

class AllRecipeController extends ChangeNotifier {
  List<RecipeDetailModel> _recipeData = [];
  List<RecipeDetailModel> get recipeData => _recipeData;

  Future<void> fetchRecipeData() async {
    try {
      var response = await http.get(Uri.parse(
          'https://appy.trycatchtech.com/v3/healthy_recipes/healthy_recipes_all_post_list'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        _recipeData = jsonList.map((json) => RecipeDetailModel.fromJson(json)).toList();
        notifyListeners();
      } else {
        debugPrint("Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching category data: $e");
    }
  }
}
