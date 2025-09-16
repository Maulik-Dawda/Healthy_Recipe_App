
class CategoryModel {
  String? id;
  String? catName;
  String? catImage;

  CategoryModel({this.id, this.catName, this.catImage});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    catName = json["cat_name"];
    catImage = json["cat_image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["cat_name"] = catName;
    data["cat_image"] = catImage;
    return data;
  }
}
