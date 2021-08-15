import 'package:json_annotation/json_annotation.dart';

import 'meta_model.dart';

part 'food_list_model.g.dart';

@JsonSerializable(createToJson: false, explicitToJson: false)
class FoodListModel {
  final Meta? meta;
  final DataFoodListModel? data;

  FoodListModel({this.meta, this.data});

  factory FoodListModel.fromJson(Map<String, dynamic> json) =>
      _$FoodListModelFromJson(json);
}

@JsonSerializable(
    createToJson: false, explicitToJson: false, fieldRename: FieldRename.snake)
class DataFoodListModel {
  final List<Food>? data;

  DataFoodListModel({
    this.data,
  });

  factory DataFoodListModel.fromJson(Map<String, dynamic> json) =>
      _$DataFoodListModelFromJson(json);
}

@JsonSerializable(
    createToJson: false, explicitToJson: false, fieldRename: FieldRename.snake)
class Food {
  final int? id;
  @JsonKey(name: "picturePath")
  final String? picturePath;
  final String? name;
  final String? description;
  final String? ingredients;
  final int? price;
  final int? rate;
  final String? types;
  final int? deletedAt;
  final int? createdAt;
  final int? updatedAt;

  Food(
      {this.id,
      this.picturePath,
      this.name,
      this.description,
      this.ingredients,
      this.price,
      this.rate,
      this.types,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);
}

// @JsonSerializable(createToJson: false, explicitToJson: false)
// class Links {
//   final String? url;
//   final String? label;
//   final bool? active;

//   Links({this.url, this.label, this.active});

//   factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);
// }
