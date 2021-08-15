import 'package:food_shop/app/core/component/data/models/response/food_list_model.dart';
import 'package:food_shop/app/core/component/data/repository/food/food_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class FoodListBloc {
  FoodRepository _repository;
  FoodListBloc(this._repository);

  final _foodList = BehaviorSubject<FoodListModel>();

  Function(FoodListModel) get updateFoodList => _foodList.sink.add;
  Stream<FoodListModel> get data => _foodList.stream;

  fecthFoodList() async {
    var result = await _repository.getFoodList();
    result.fold((l) {
      print("Something error when request food list $l");

      return _foodList.addError(l.error!);
    }, (value) {
      return updateFoodList(value);
    });
  }

  dispose() {
    _foodList.close();
  }
}
