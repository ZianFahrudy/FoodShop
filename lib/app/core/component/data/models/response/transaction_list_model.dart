import 'package:food_shop/app/core/component/data/models/response/transaction_model.dart';

import 'package:json_annotation/json_annotation.dart';

import 'meta_model.dart';

part 'transaction_list_model.g.dart';

@JsonSerializable(createToJson: false, explicitToJson: false)
class TransactionListModel {
  final Meta? meta;
  final DataTransactionList? data;
  TransactionListModel(this.meta, this.data);

  factory TransactionListModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionListModelFromJson(json);
}

@JsonSerializable(createToJson: false, explicitToJson: false)
class DataTransactionList {
  final List<DataTransactionModel>? data;
  final int? total;

  DataTransactionList(this.data, this.total);
  factory DataTransactionList.fromJson(Map<String, dynamic> json) =>
      _$DataTransactionListFromJson(json);
}
