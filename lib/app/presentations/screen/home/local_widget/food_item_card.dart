import 'package:flutter/material.dart';
import 'package:food_shop/app/core/common/size.dart';


import 'package:food_shop/app/presentations/screen/home/local_widget/rating_star.dart';

class FoodItemCard extends StatelessWidget {
  const FoodItemCard(
      {Key? key,
      this.name,
      this.price,
      this.rate,
      this.picturePath,
      this.marginTop,
      this.marginBottom})
      : super(key: key);
  final String? picturePath;
  final String? name;
  final String? price;
  final int? rate;
  final double? marginTop;
  final double? marginBottom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: Sizes.defaultMargin,
          right: Sizes.defaultMargin,
          bottom: marginBottom ?? 0,
          top: marginTop ?? 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  picturePath!,
                  width: 60,
                  height: 65,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name!,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    price!,
                    style: Theme.of(context).textTheme.bodyText2,
                  )
                ],
              ),
            ]),
          ),
          Row(
            children: [
              RatingStar(
                rate: rate!,
              ),
              SizedBox(width: 10),
              Text(rate.toString(),
                  style: Theme.of(context).textTheme.bodyText2)
            ],
          )
        ],
      ),
    );
  }
}
