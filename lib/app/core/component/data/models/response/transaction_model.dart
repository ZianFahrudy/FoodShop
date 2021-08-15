import 'package:food_shop/app/core/component/data/models/response/user_model.dart';

import 'package:json_annotation/json_annotation.dart';

import 'food_list_model.dart';
import 'meta_model.dart';

part 'transaction_model.g.dart';

@JsonSerializable(createToJson: false, explicitToJson: false)
class TransactionModel {
  final Meta? meta;
  final DataTransactionModel? data;

  TransactionModel({this.meta, this.data});

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}

@JsonSerializable(
    createToJson: false, explicitToJson: false, fieldRename: FieldRename.snake)
class DataTransactionModel {
  final int? id;
  final int? foodId;
  final int? userId;
  final int? quantity;
  final int? total;
  final String? status;
  final String? paymentUrl;
  final int? deletedAt;
  final int? createdAt;
  final int? updatedAt;
  final Food? food;
  final UserModel? user;

  DataTransactionModel(
      {this.id,
      this.foodId,
      this.userId,
      this.quantity,
      this.total,
      this.status,
      this.paymentUrl,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.food,
      this.user});

  factory DataTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$DataTransactionModelFromJson(json);
}
