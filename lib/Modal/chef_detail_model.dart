
class ChefDetailModel {
  String? id;
  String? name;
  String? description;
  String? image;
  String? profileUrl;
  String? instagramUrl;

  ChefDetailModel({this.id, this.name, this.description, this.image, this.profileUrl, this.instagramUrl});

  ChefDetailModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    image = json["image"];
    profileUrl = json["profile_url"];
    instagramUrl = json["instagram_url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["description"] = description;
    data["image"] = image;
    data["profile_url"] = profileUrl;
    data["instagram_url"] = instagramUrl;
    return data;
  }
}
