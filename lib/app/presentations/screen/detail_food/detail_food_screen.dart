import 'package:flutter/material.dart';
import 'package:food_shop/app/core/component/data/models/response/food_list_model.dart';
import 'package:get/get.dart';

import 'local_widget/content_food_detail.dart';
import 'local_widget/food_image_detail.dart';

class DetailFoodScreen extends StatefulWidget {
  DetailFoodScreen({Key? key}) : super(key: key);

  @override
  _DetailFoodScreenState createState() => _DetailFoodScreenState();
}

class _DetailFoodScreenState extends State<DetailFoodScreen> {
  late Food food;

  @override
  void initState() {
    food = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FoodImageDetail(food: food),
            ContentFoodDetail(food: food),
          ],
        ),
      ),
    );
  }
}
