import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class SelectCategoryController extends ChangeNotifier{
  List? _catName;
  final Set<int> _selectedIndexes = {};
  

  List? get catName => _catName;
  Set<int> get selectedIndexes => _selectedIndexes;

  void getCatName()async{
      var response = await http.get(Uri.parse('https://mapi.trycatchtech.com/v3/healthy_recipes/healthy_recipes_parent_category_list'));
      if (response.statusCode == 200){
        _catName = jsonDecode(response.body);
        notifyListeners();
      }
  }

  void toggleSelection(var  index) {
    if (_selectedIndexes.contains(index)) {
      _selectedIndexes.remove(index);
    } else {
      _selectedIndexes.add(index);

    }
    notifyListeners();
  }
}
