import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    this.message,
    this.data,
  });

  String? message;
  List<Datum>? data;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };


}

class Datum {
  Datum({
    this.id,
    this.categoryId,
    this.image,
    this.categoryName,
    this.categoryLearners,
    this.hasSubCategories,
    this.content,
    this.subCategories
  });

  int? id;
  dynamic categoryId;
  String? image;
  String? categoryName;
  dynamic categoryLearners;
  bool? hasSubCategories;
  dynamic content;
  List<DatumSubCategory>? subCategories;

  static Map<String, dynamic> toMap(Datum music) => {
    "id": music.id,
    "categoryId": music.categoryId,
    "image": music.image,
    "categoryName": music.categoryName,
    "categoryLearners": music.categoryLearners,
    "hasSubCategories": music.hasSubCategories,
    "content": music.content,
    "subCategories": List<dynamic>.from(music.subCategories!.map((x) => x.toJson()))
  };


  static String encode(List<Datum> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => Datum.toMap(music))
        .toList(),
  );

  static List<Datum> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<Datum>((item) => Datum.fromJson(item))
          .toList();

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    categoryId: json["categoryId"],
    image: json["image"],
    categoryName: json["categoryName"],
    categoryLearners: json["categoryLearners"],
    hasSubCategories: json["hasSubCategories"],
    content: json["content"],
    subCategories: List<DatumSubCategory>.from(json["subCategories"].map((x) => DatumSubCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "categoryId": categoryId,
    "image": image,
    "categoryName": categoryName,
    "categoryLearners": categoryLearners,
    "hasSubCategories": hasSubCategories,
    "content": content,
    "subCategories": List<dynamic>.from(subCategories!.map((x) => x.toJson()))
  };
}

class DatumSubCategory {
  DatumSubCategory({
    this.name,
    this.hasSubCategories,
    this.subCategories,
    this.categoryContentLink,
  });

  String? name;
  bool? hasSubCategories;
  List<SubCategorySubCategory>? subCategories;
  List<String>? categoryContentLink;

  factory DatumSubCategory.fromJson(Map<String, dynamic> json) => DatumSubCategory(
    name: json["name"],
    hasSubCategories: json["hasSubCategories"],
    subCategories: List<SubCategorySubCategory>.from(json["subCategories"].map((x) => SubCategorySubCategory.fromJson(x))),
    categoryContentLink: json["categoryContentLink"] == null ? null : List<String>.from(json["categoryContentLink"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "hasSubCategories": hasSubCategories,
    "subCategories": List<dynamic>.from(subCategories!.map((x) => x.toJson())),
    "categoryContentLink": categoryContentLink == null ? null : List<dynamic>.from(categoryContentLink!.map((x) => x)),
  };
}

class SubCategorySubCategory {
  SubCategorySubCategory({
    this.name,
  });

  String? name;

  factory SubCategorySubCategory.fromJson(Map<String, dynamic> json) => SubCategorySubCategory(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}

