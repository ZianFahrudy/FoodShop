import 'package:dartz/dartz.dart';
import 'package:food_shop/app/core/component/data/models/response/food_list_model.dart';
import 'package:food_shop/app/core/exception/failure.dart';


abstract class FoodRepository {
  Future<Either<Failure, FoodListModel>> getFoodList();

}