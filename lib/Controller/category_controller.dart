import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:healthy_recipe/Modal/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryController extends ChangeNotifier {
  List<CategoryModel> _catData = [];
  List<CategoryModel> get catData => _catData;

  Future<void> fetchData() async {
    try {
      var response = await http.get(Uri.parse(
          'https://appy.trycatchtech.com/v3/healthy_recipes/healthy_recipes_category_list'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        _catData = jsonList.map((json) => CategoryModel.fromJson(json)).toList();
        notifyListeners();
      } else {
        debugPrint("Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching category data: $e");
    }
  }
}
