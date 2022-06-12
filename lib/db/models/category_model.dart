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
     required this.subCategories,
     this.createdAt,
     this.updatedAt,
  });

  int? id;
  dynamic categoryId;
  String? image;
  String? categoryName;
  int? categoryLearners;
  bool? hasSubCategories;
  dynamic? content;
  List<DatumSubCategory> subCategories = [];
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    categoryId: json["categoryId"],
    image: json["image"],
    categoryName: json["categoryName"],
    categoryLearners: json["categoryLearners"],
    hasSubCategories: json["hasSubCategories"],
    content: json["content"],
    subCategories: List<DatumSubCategory>.from(json["subCategories"].map((x) => DatumSubCategory.fromJson(x))),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "categoryId": categoryId,
    "image": image,
    "categoryName": categoryName,
    "categoryLearners": categoryLearners,
    "hasSubCategories": hasSubCategories,
    "content": content,
    "subCategories": List<dynamic>.from(subCategories.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class DatumSubCategory {
  DatumSubCategory({
    this.name,
    this.hasSubCategories,
    required this.categoryContentLink,
    required this.subCategories,
  });

  String? name;
  bool? hasSubCategories;
  List<String> categoryContentLink = [];
  List<SubCategorySubCategory> subCategories = [];

  factory DatumSubCategory.fromJson(Map<String, dynamic> json) => DatumSubCategory(
    name: json["name"],
    hasSubCategories: json["hasSubCategories"],
    categoryContentLink: List<String>.from(json["categoryContentLink"].map((x) => x)),
    subCategories: List<SubCategorySubCategory>.from(json["subCategories"].map((x) => SubCategorySubCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "hasSubCategories": hasSubCategories,
    "categoryContentLink": List<dynamic>.from(categoryContentLink.map((x) => x)),
    "subCategories": List<dynamic>.from(subCategories.map((x) => x.toJson())),
  };
}

class SubCategorySubCategory {
  SubCategorySubCategory({
    required this.name,
  });

  String name;

  factory SubCategorySubCategory.fromJson(Map<String, dynamic> json) => SubCategorySubCategory(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
