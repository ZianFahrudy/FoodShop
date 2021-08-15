import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:food_shop/app/core/component/data/models/response/food_list_model.dart';
import 'package:food_shop/app/core/constant/api_path/api_path.dart';
import 'package:food_shop/app/core/constant/constants.dart';
import 'package:food_shop/app/core/exception/failure.dart';

import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

import 'food_repository.dart';

@LazySingleton(as: FoodRepository)
class FoodRepositoryImpl extends FoodRepository {
  final storage = GetStorage();

  BaseOptions options = BaseOptions(
      baseUrl: Constant.baseURL,
      connectTimeout: 15000,
      receiveTimeout: 15000,
      headers: {'Content-Type': 'application/json'},
      receiveDataWhenStatusError: true);

  @override
  Future<Either<Failure, FoodListModel>> getFoodList() async {
    Dio dio = Dio(options);
    Response response;
    try {
      response = await dio.get(ApiPath.food);
      var data = FoodListModel.fromJson(response.data);

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
