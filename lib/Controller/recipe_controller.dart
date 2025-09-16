import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:healthy_recipe/Modal/recipe_detail_model.dart';
import 'package:http/http.dart' as http;

class RecipeController extends ChangeNotifier {
  List<RecipeDetailModel> _catData = [];
  List<RecipeDetailModel> get catData => _catData;

  late String _id;
  String get id => _id;

  void setIdAndFetch(String parentId) {
    _id = parentId;
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var response = await http.get(Uri.parse(
          'https://appy.trycatchtech.com/v3/healthy_recipes/healthy_recipes_post_list/?category_id=$_id'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        _catData = jsonList.map((json) => RecipeDetailModel.fromJson(json)).toList();
        notifyListeners();
      } else {
        debugPrint("Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching category data: $e");
    }
  }
}
