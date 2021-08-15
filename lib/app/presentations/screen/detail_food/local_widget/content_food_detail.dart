import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_shop/app/core/common/palette.dart';

import 'package:food_shop/app/core/component/data/models/response/food_list_model.dart';
import 'package:food_shop/app/presentations/screen/checkout/checkout_screen.dart';
import 'package:food_shop/app/presentations/screen/home/local_widget/rating_star.dart';
import 'package:food_shop/app/presentations/widget/button/button_widget.dart';
import 'package:get/get.dart';

class ContentFoodDetail extends StatefulWidget {
  const ContentFoodDetail({
    Key? key,
    this.food,
  }) : super(key: key);

  final Food? food;

  @override
  _ContentFoodDetailState createState() => _ContentFoodDetailState();
}

class _ContentFoodDetailState extends State<ContentFoodDetail> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Get.height,
      margin: EdgeInsets.only(top: 300),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.food!.name!,
                        style: Theme.of(context).textTheme.headline6),
                    Row(
                      children: [
                        RatingStar(
                          rate: widget.food!.rate!,
                        ),
                        SizedBox(width: 6),
                        Text(widget.food!.rate!.toString(),
                            style: Theme.of(context).textTheme.headline6),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          quantity = min(999, quantity + 1);
                        });
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Get.isDarkMode
                                    ? Palette.greyColor
                                    : Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(child: Text("+")),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(quantity.toString()),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          quantity = max(1, quantity - 1);
                        });
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Get.isDarkMode
                                    ? Palette.greyColor
                                    : Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(child: Text("-")),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 20),
            Text(
              widget.food!.description!,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Palette.greyColor),
            ),
            SizedBox(height: 10),
            Text(
              "Ingredients",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              widget.food!.ingredients!,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Palette.greyColor),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Price",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.food!.price.toString(),
                          style: Theme.of(context).textTheme.headline6),
                    ],
                  ),
                ),
                ButtonWidget(
                    text: "Order Now",
                    width: 140,
                    height: 45,
                    color: Get.isDarkMode
                        ? Colors.amber
                        : Theme.of(context).primaryColor,
                    onPressed: () => Get.to(() => CheckoutScreen(
                          foodId: widget.food!.id!,
                          quantity: quantity,
                          foodName: widget.food!.name,
                          picturePath: widget.food!.picturePath,
                          price: widget.food!.price,
                        )))
              ],
            )
          ],
        ),
      ),
    );
  }
}
