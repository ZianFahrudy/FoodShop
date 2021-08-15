import 'package:flutter/material.dart';
import 'package:food_shop/app/core/component/data/models/response/food_list_model.dart';

class FoodImageDetail extends StatelessWidget {
  const FoodImageDetail({
    Key? key,
    required this.food,
  }) : super(key: key);

  final Food food;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      food.picturePath!,
      width: double.infinity,
      height: 330,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
    );
  }
}
