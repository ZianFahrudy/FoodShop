// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) {
  return TransactionModel(
    meta: json['meta'] == null
        ? null
        : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    data: json['data'] == null
        ? null
        : DataTransactionModel.fromJson(json['data'] as Map<String, dynamic>),
  );
}

DataTransactionModel _$DataTransactionModelFromJson(Map<String, dynamic> json) {
  return DataTransactionModel(
    id: json['id'] as int?,
    foodId: json['food_id'] as int?,
    userId: json['user_id'] as int?,
    quantity: json['quantity'] as int?,
    total: json['total'] as int?,
    status: json['status'] as String?,
    paymentUrl: json['payment_url'] as String?,
    deletedAt: json['deleted_at'] as int?,
    createdAt: json['created_at'] as int?,
    updatedAt: json['updated_at'] as int?,
    food: json['food'] == null
        ? null
        : Food.fromJson(json['food'] as Map<String, dynamic>),
    user: json['user'] == null
        ? null
        : UserModel.fromJson(json['user'] as Map<String, dynamic>),
  );
}
