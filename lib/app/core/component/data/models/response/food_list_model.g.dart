// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodListModel _$FoodListModelFromJson(Map<String, dynamic> json) {
  return FoodListModel(
    meta: json['meta'] == null
        ? null
        : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    data: json['data'] == null
        ? null
        : DataFoodListModel.fromJson(json['data'] as Map<String, dynamic>),
  );
}

DataFoodListModel _$DataFoodListModelFromJson(Map<String, dynamic> json) {
  return DataFoodListModel(
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => Food.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Food _$FoodFromJson(Map<String, dynamic> json) {
  return Food(
    id: json['id'] as int?,
    picturePath: json['picturePath'] as String?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    ingredients: json['ingredients'] as String?,
    price: json['price'] as int?,
    rate: json['rate'] as int?,
    types: json['types'] as String?,
    deletedAt: json['deleted_at'] as int?,
    createdAt: json['created_at'] as int?,
    updatedAt: json['updated_at'] as int?,
  );
}
