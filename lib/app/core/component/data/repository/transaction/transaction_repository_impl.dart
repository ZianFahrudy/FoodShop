import 'package:dio/dio.dart';

import 'package:food_shop/app/core/component/data/models/request/checkout_body.dart';
import 'package:food_shop/app/core/component/data/models/response/transaction_list_model.dart';
import 'package:food_shop/app/core/component/data/models/response/transaction_model.dart';
import 'package:food_shop/app/core/component/data/repository/transaction/transaction_repository.dart';
import 'package:food_shop/app/core/constant/api_path/api_path.dart';
import 'package:food_shop/app/core/constant/constants.dart';
import 'package:food_shop/app/core/constant/key_constants.dart';
import 'package:food_shop/app/core/exception/failure.dart';

import 'package:dartz/dartz.dart';

import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TransactionRepository)
class TransactionRepositoryImpl extends TransactionRepository {
  final storage = GetStorage();

  BaseOptions options = BaseOptions(
      baseUrl: Constant.baseURL,
      connectTimeout: 15000,
      receiveTimeout: 15000,
      headers: {'Content-Type': 'application/json'},
      receiveDataWhenStatusError: true);
  Future<Either<Failure, TransactionModel>> checkout(CheckoutBody body) async {
    Dio dio = Dio(options);
    Response response;
    try {
      response = await dio.post(ApiPath.checkout,
          data: body.toJson(),
          options: Options(headers: {
            'Authorization':
                "${storage.read(KeyConstant.tokenType)} ${storage.read(KeyConstant.accessToken)}"
          }));
      var data = TransactionModel.fromJson(response.data);

      return right(data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        var errorData = e.response!.data['meta']['message'];
        var errorResult = Failure(errorData);

        return left(errorResult);
      }
      return left(Failure("Something error"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, TransactionListModel>> getTransactionList() async {
    Dio dio = Dio(options);
    Response response;
    try {
      response = await dio.get(ApiPath.transaction,
          options: Options(headers: {
            'Authorization':
                "${storage.read(KeyConstant.tokenType)} ${storage.read(KeyConstant.accessToken)}"
          }),
          queryParameters: {'limit': ''});
      var data = TransactionListModel.fromJson(response.data);

      return right(data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        var errorData = e.response!.data['meta']['message'];
        var errorResult = Failure(errorData);

        return left(errorResult);
      }
      return left(Failure("Something error"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
