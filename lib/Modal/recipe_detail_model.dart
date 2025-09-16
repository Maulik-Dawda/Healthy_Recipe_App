
class RecipeDetailModel {
  String? id;
  String? title;
  String? postImage;
  String? time;
  String? ingredients;
  String? methods;
  String? calories;
  String? about;
  String? chefName;

  RecipeDetailModel({this.id, this.title, this.postImage, this.time, this.ingredients, this.methods, this.calories, this.about, this.chefName});

  RecipeDetailModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    postImage = json["post_image"];
    time = json["time"];
    ingredients = json["ingredients"];
    methods = json["methods"];
    calories = json["calories"];
    about = json["about"];
    chefName = json["chef_name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["post_image"] = postImage;
    data["time"] = time;
    data["ingredients"] = ingredients;
    data["methods"] = methods;
    data["calories"] = calories;
    data["about"] = about;
    data["chef_name"] = chefName;
    return data;
  }
}
