import 'package:flutter/material.dart';
import 'package:food_shop/app/core/common/palette.dart';
import 'package:food_shop/app/core/common/size.dart';


class ItemOrdercard extends StatefulWidget {
  const ItemOrdercard(
      {Key? key,
      this.foodName,
      this.price,
      this.picturePath,
      this.quantity,
      this.total,
      this.tax,
      this.driverFee})
      : super(key: key);

  final String? foodName;
  final int? price;
  final String? picturePath;
  final int? quantity;
  final int? total;
  final double? tax;
  final int? driverFee;

  @override
  _ItemOrdercardState createState() => _ItemOrdercardState();
}

class _ItemOrdercardState extends State<ItemOrdercard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Sizes.defaultMargin),
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Item Ordered",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.picturePath!,
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
                        widget.foodName!,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        widget.price!.toString(),
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    ],
                  ),
                ]),
                Text("${widget.quantity} Items"),
              ],
            ),
          ),
          Text("Detail Transaction",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.foodName!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Palette.greyColor)),
              Text((widget.quantity! * widget.price!).toString(),
                  style: Theme.of(context).textTheme.bodyText2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Driver",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Palette.greyColor)),
              Text(widget.driverFee.toString(),
                  style: Theme.of(context).textTheme.bodyText2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Tax 10%",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Palette.greyColor)),
              Text(widget.tax!.toInt().toString(),
                  style: Theme.of(context).textTheme.bodyText2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Price",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Palette.greyColor)),
              Text(widget.total.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Palette.greenColor)),
            ],
          ),
        ],
      ),
    );
  }
}
