import 'package:flutter/material.dart';
import 'package:food_shop/app/core/common/palette.dart';

import 'package:food_shop/app/core/component/blocs/food/food_list_bloc.dart';

import 'package:food_shop/app/core/component/data/models/response/food_list_model.dart';
import 'package:food_shop/app/core/injection/injection.dart';

import 'package:get/get.dart';

import 'food_item_card.dart';

class FoodCategory {
  final String title;
  FoodCategory(this.title);
}

List<FoodCategory> category = [
  FoodCategory("New Taste"),
  FoodCategory("Popular"),
  FoodCategory("Recommended"),
];

class FoodBarCategory extends StatefulWidget {
  FoodBarCategory({
    Key? key,
  }) : super(key: key);

  @override
  _FoodBarCategoryState createState() => _FoodBarCategoryState();
}

class _FoodBarCategoryState extends State<FoodBarCategory> {
  int selectedIndex = 0;

  final foodListBloc = getIt<FoodListBloc>();

  @override
  void initState() {
    foodListBloc.fecthFoodList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: Get.height * 0.07,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border(
                    bottom: BorderSide(color: Theme.of(context).dividerColor))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: category
                      .asMap()
                      .map((i, value) => MapEntry(
                          i,
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = i;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  value.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontWeight: selectedIndex == i
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                ),
                                selectedIndex == i
                                    ? Container(
                                        height: 5,
                                        width: 5,
                                        decoration: BoxDecoration(
                                            color: Get.isDarkMode
                                                ? Palette.greyColor
                                                : Theme.of(context)
                                                    .primaryColor,
                                            shape: BoxShape.circle),
                                      )
                                    : SizedBox.shrink()
                              ],
                            ),
                          )))
                      .values
                      .toList(),
                ),
              ],
            ),
          ),
          StreamBuilder<FoodListModel>(
              stream: foodListBloc.data,
              builder: (context, snapshot) {
                List<Food> foodList = [];
                if (snapshot.hasData) {
                  foodList = snapshot.data!.data!.data!;
                  return Container(
                      width: double.infinity,
                      color: Theme.of(context).cardColor,
                      child: selectedIndex == 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: foodList.length,
                              itemBuilder: (context, i) {
                                if (foodList[i].types!.contains("new_food")) {
                                  return FoodItemCard(
                                    marginTop: i == 0 ? 15 : 0,
                                    marginBottom: 15,
                                    name: foodList[i].name,
                                    picturePath: foodList[i].picturePath,
                                    price: foodList[i].price.toString(),
                                    rate: foodList[i].rate,
                                  );
                                }
                                return SizedBox.shrink();
                              })
                          : selectedIndex == 1
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: foodList.length,
                                  itemBuilder: (context, i) {
                                    if (foodList[i]
                                        .types!
                                        .contains("popular")) {
                                      return FoodItemCard(
                                        marginTop: 15,
                                        marginBottom: 15,
                                        name: foodList[i].name,
                                        picturePath: foodList[i].picturePath,
                                        price: foodList[i].price.toString(),
                                        rate: foodList[i].rate,
                                      );
                                    }
                                    return SizedBox.shrink();
                                  })
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: foodList.length,
                                  itemBuilder: (context, i) {
                                    if (foodList[i]
                                        .types!
                                        .contains("recommended")) {
                                      return FoodItemCard(
                                        marginTop: 15,
                                        marginBottom: 15,
                                        name: foodList[i].name,
                                        picturePath: foodList[i].picturePath,
                                        price: foodList[i].price.toString(),
                                        rate: foodList[i].rate,
                                      );
                                    }
                                    return SizedBox.shrink();
                                  }));
                }

                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: CircularProgressIndicator(),
                ));
              }),
        ],
      ),
    );
  }
}
