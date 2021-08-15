import 'package:dartz/dartz.dart';
import 'package:food_shop/app/core/component/data/models/request/checkout_body.dart';
import 'package:food_shop/app/core/component/data/models/response/transaction_list_model.dart';
import 'package:food_shop/app/core/component/data/models/response/transaction_model.dart';
import 'package:food_shop/app/core/exception/failure.dart';


abstract class TransactionRepository {
  Future<Either<Failure, TransactionModel>> checkout(CheckoutBody body);
  Future<Either<Failure, TransactionListModel>> getTransactionList();
}
