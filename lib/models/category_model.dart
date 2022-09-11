class ResultCategoryModel {
  ResultCategoryModel({
    this.data,
    this.message,
    this.status,
  });

  List<CategoryModel>? data;
  String? message;
  bool? status;

  factory ResultCategoryModel.fromJson(Map<String, dynamic> json) =>
      ResultCategoryModel(
        data: List<CategoryModel>.from(
            json["data"].map((x) => CategoryModel.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class CategoryModel {
  CategoryModel({
    this.categoryId,
    this.categoryWalletId,
    this.categoryTitle,
    this.categoryType,
    this.categoryIsActive,
  });

  int? categoryId;
  int? categoryWalletId;
  String? categoryTitle;
  String? categoryType;
  bool? categoryIsActive;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categoryId: json["category_id"],
        categoryWalletId: json["category_wallet_id"],
        categoryTitle: json["category_title"],
        categoryType: json["category_type"],
        categoryIsActive: json["category_is_active"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_wallet_id": categoryWalletId,
        "category_title": categoryTitle,
        "category_type": categoryType,
        "category_is_active": categoryIsActive,
      };
}
