import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:healthy_recipe/Modal/chef_detail_model.dart';
import 'package:http/http.dart' as http;

class ChefDetailController extends ChangeNotifier {
  List<ChefDetailModel> _chefData = [];
  List<ChefDetailModel> get chefData => _chefData;

  Future<void> fetchData() async {
    try {
      var response = await http.get(Uri.parse(
          'https://appy.trycatchtech.com/v3/healthy_recipes/healthy_recipes_chefs_list'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        _chefData = jsonList.map((json) => ChefDetailModel.fromJson(json)).toList();
        notifyListeners();
      } else {
        debugPrint("Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching category data: $e");
    }
  }
}
