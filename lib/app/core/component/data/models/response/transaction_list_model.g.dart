// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionListModel _$TransactionListModelFromJson(Map<String, dynamic> json) {
  return TransactionListModel(
    json['meta'] == null
        ? null
        : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : DataTransactionList.fromJson(json['data'] as Map<String, dynamic>),
  );
}

DataTransactionList _$DataTransactionListFromJson(Map<String, dynamic> json) {
  return DataTransactionList(
    (json['data'] as List<dynamic>?)
        ?.map((e) => DataTransactionModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['total'] as int?,
  );
}
