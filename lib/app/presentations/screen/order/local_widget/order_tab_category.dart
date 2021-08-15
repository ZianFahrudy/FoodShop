import 'package:flutter/material.dart';
import 'package:food_shop/app/core/common/palette.dart';
import 'package:food_shop/app/core/common/size.dart';
import 'package:food_shop/app/core/component/blocs/transaction/transaction_list/transaction_list_bloc.dart';

import 'package:food_shop/app/core/component/data/models/response/transaction_list_model.dart';
import 'package:food_shop/app/core/component/data/models/response/transaction_model.dart';
import 'package:food_shop/app/core/injection/injection.dart';
import 'package:food_shop/app/core/utill/url_launcher.dart';
import 'package:get/get.dart';



class FoodCategory {
  final String title;
  FoodCategory(this.title);
}

List<FoodCategory> category = [
  FoodCategory("All"),
  FoodCategory("Pending"),
  FoodCategory("Success"),
  FoodCategory("Cancelled"),
];

class OrderTabBar extends StatefulWidget {
  OrderTabBar({
    Key? key,
    required this.transactionListBloc,
  }) : super(key: key);

  final TransactionListBloc transactionListBloc;

  @override
  _OrderTabBarState createState() => _OrderTabBarState();
}

class _OrderTabBarState extends State<OrderTabBar> {
  int selectedIndex = 0;

  final transactionbloc = getIt<TransactionListBloc>();

  @override
  void initState() {
    // transactionbloc.fetchTransactionList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                                          color: Theme.of(context).primaryColor,
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
        StreamBuilder<TransactionListModel>(
          stream: widget.transactionListBloc.data,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final transaction = snapshot.data!.data!.data;

              return selectedIndex == 0
                  ? buildAllOrder(transaction!)
                  : selectedIndex == 1
                      ? buildPendingOrder(transaction!)
                      : selectedIndex == 2
                          ? buildSuccessOrder(transaction!)
                          : buildCancelledOrder(transaction!);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }

  Container buildCancelledOrder(List<DataTransactionModel> transaction) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).cardColor,
      child: transaction.isEmpty
          ? buildEmptyOrder()
          : buildCanceledListViewBuilder(transaction),
    );
  }

  ListView buildCanceledListViewBuilder(
      List<DataTransactionModel> transaction) {
    return ListView.builder(
        itemCount: transaction.length,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, i) {
          if (transaction[i].status == "CANCELLED") {
            return Padding(
              padding: EdgeInsets.only(
                  left: Sizes.defaultMargin,
                  bottom: 15,
                  top: i == 0 ? 15 : 0,
                  right: Sizes.defaultMargin),
              child: GestureDetector(
                onTap: transaction[i].status == 'PENDING'
                    ? () => Launch.openUrl(url: transaction[i].paymentUrl!)
                    : () {},
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        transaction[i].food!.picturePath!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(transaction[i].food!.name!),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(transaction[i].quantity.toString() + ' items'),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              width: 3,
                              height: 3,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Palette.greyColor,
                              ),
                            ),
                            Text(transaction[i].total.toString()),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(transaction[i].status!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: transaction[i].status == 'SUCCESS'
                                ? Palette.greenColor
                                : Palette.redColor,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            );
          }
          return SizedBox.shrink();
        });
  }

  Container buildSuccessOrder(List<DataTransactionModel> transaction) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).cardColor,
      child: transaction.isEmpty
          ? buildEmptyOrder()
          : buildSuccessListViewBuilder(transaction),
    );
  }

  ListView buildSuccessListViewBuilder(List<DataTransactionModel> transaction) {
    return ListView.builder(
        itemCount: transaction.length,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, i) {
          if (transaction[i].status == "SUCCESS") {
            return Padding(
              padding: EdgeInsets.only(
                  left: Sizes.defaultMargin,
                  bottom: 15,
                  top: i == 0 ? 15 : 0,
                  right: Sizes.defaultMargin),
              child: GestureDetector(
                onTap: transaction[i].status == 'PENDING'
                    ? () => Launch.openUrl(url: transaction[i].paymentUrl!)
                    : () {},
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        transaction[i].food!.picturePath!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(transaction[i].food!.name!),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(transaction[i].quantity.toString() + ' items'),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              width: 3,
                              height: 3,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Palette.greyColor,
                              ),
                            ),
                            Text(transaction[i].total.toString()),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(transaction[i].status!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: transaction[i].status == 'SUCCESS'
                                ? Palette.greenColor
                                : Palette.redColor,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            );
          }
          return SizedBox.shrink();
        });
  }

  Container buildPendingOrder(List<DataTransactionModel> transaction) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).cardColor,
      child: transaction.isEmpty
          ? buildEmptyOrder()
          : buildPendingListViewBuilder(transaction),
    );
  }

  ListView buildPendingListViewBuilder(List<DataTransactionModel> transaction) {
    return ListView.builder(
        itemCount: transaction.length,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, i) {
          if (transaction[i].status == "PENDING") {
            return Padding(
              padding: EdgeInsets.only(
                  left: Sizes.defaultMargin,
                  bottom: 15,
                  top: i == 0 ? 15 : 0,
                  right: Sizes.defaultMargin),
              child: GestureDetector(
                onTap: transaction[i].status == 'PENDING'
                    ? () => Launch.openUrl(url: transaction[i].paymentUrl!)
                    : () {},
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        transaction[i].food!.picturePath!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(transaction[i].food!.name!),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(transaction[i].quantity.toString() + ' items'),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              width: 3,
                              height: 3,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Palette.greyColor,
                              ),
                            ),
                            Text(transaction[i].total.toString()),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(transaction[i].status!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: transaction[i].status == 'SUCCESS'
                                ? Palette.greenColor
                                : Palette.redColor,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            );
          }
          return SizedBox.shrink();
        });
  }

  Container buildAllOrder(List<DataTransactionModel> transaction) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).cardColor,
      child: transaction.isEmpty
          ? buildEmptyOrder()
          : buildAllListViewBuilder(transaction),
    );
  }

  Column buildEmptyOrder() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(height: 20),
      Image.asset(
        "assets/image/hamburger.png",
        width: Get.width * 0.6,
      ),
      SizedBox(height: 20),
      Text("Order Empty!", style: Theme.of(context).textTheme.headline5),
      SizedBox(height: 20),
    ]);
  }

  ListView buildAllListViewBuilder(List<DataTransactionModel> transaction) {
    return ListView.builder(
        itemCount: transaction.length,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.only(
                left: Sizes.defaultMargin,
                bottom: 15,
                top: i == 0 ? 15 : 0,
                right: Sizes.defaultMargin),
            child: GestureDetector(
              onTap: transaction[i].status == 'PENDING'
                  ? () => Launch.openUrl(url: transaction[i].paymentUrl!)
                  : () {},
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      transaction[i].food!.picturePath!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(transaction[i].food!.name!),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(transaction[i].quantity.toString() + ' items'),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            width: 3,
                            height: 3,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Palette.greyColor,
                            ),
                          ),
                          Text(transaction[i].total.toString()),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(transaction[i].status!,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: transaction[i].status == 'SUCCESS'
                              ? Palette.greenColor
                              : Palette.redColor,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        });
  }
}
