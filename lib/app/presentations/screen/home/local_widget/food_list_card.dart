import 'package:flutter/material.dart';
import 'package:food_shop/app/core/common/size.dart';
import 'package:food_shop/app/core/component/blocs/food/food_list_bloc.dart';

import 'package:food_shop/app/core/component/data/models/response/food_list_model.dart';
import 'package:food_shop/app/core/injection/injection.dart';

import 'package:food_shop/app/presentations/screen/detail_food/detail_food_screen.dart';
import 'package:get/get.dart';

import 'rating_star.dart';

class FoodListCard extends StatefulWidget {
  const FoodListCard({Key? key}) : super(key: key);

  @override
  _FoodListCardState createState() => _FoodListCardState();
}

class _FoodListCardState extends State<FoodListCard> {
  final foodListBloc = getIt<FoodListBloc>();
  @override
  void initState() {
    foodListBloc.fecthFoodList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FoodListModel>(
        stream: foodListBloc.data,
        builder: (context, snapshot) {
          List<Food> food = [];

          if (snapshot.hasData) {
            food = snapshot.data!.data!.data!;
            return Container(
              margin: EdgeInsets.only(bottom: Sizes.defaultMargin),
              height: Get.height * 0.3,
              child: ListView.builder(
                  itemCount: food.length,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () => Get.to(() => DetailFoodScreen(),
                            arguments: food[index]),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(15)),
                          margin: EdgeInsets.only(
                              left: index == 0 ? Sizes.defaultMargin : 0,
                              top: Sizes.defaultMargin,
                              right: index == food.length - 1
                                  ? Sizes.defaultMargin
                                  : 15),
                          height: Get.height * 0.19,
                          width: Get.width * 0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15)),
                                child: Image.network(
                                  food[index].picturePath!,
                                  height: 140,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(food[index].name!),
                                      Row(children: [
                                        RatingStar(
                                          rate: food[index].rate!,
                                        ),
                                        SizedBox(width: 5),
                                        Text(food[index].rate.toString()),
                                      ]),
                                    ]),
                              )
                            ],
                          ),
                        ),
                      )),
            );
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
