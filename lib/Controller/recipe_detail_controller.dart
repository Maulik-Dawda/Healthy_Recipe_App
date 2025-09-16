import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:healthy_recipe/Modal/recipe_detail_model.dart';
import 'package:http/http.dart' as http;

class RecipeDetailController extends ChangeNotifier {
  List<RecipeDetailModel> _recipeData = [];
  List<RecipeDetailModel> get recipeData => _recipeData;

  late String _id;
  String get id => _id;

  void setIdAndFetch(String childId) {
    _id = childId;
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var response = await http.get(Uri.parse(
          'https://appy.trycatchtech.com/v3/healthy_recipes/get_single_post/?id=$_id'));

      if (response.statusCode == 200) {
        final dynamic jsonMap = jsonDecode(response.body);

        // If response is a map/object, wrap it in a list
        if (jsonMap is Map<String, dynamic>) {
          _recipeData = [RecipeDetailModel.fromJson(jsonMap)];
        } else if (jsonMap is List) {
          _recipeData = jsonMap.map((json) => RecipeDetailModel.fromJson(json)).toList();
        }

        notifyListeners();
      } else {
        debugPrint("Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching recipe detail data: $e");
    }
  }

}
