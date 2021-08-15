import 'package:flutter/material.dart';
import 'package:food_shop/app/core/common/palette.dart';


import 'package:food_shop/app/core/component/data/models/response/transaction_model.dart';
import 'package:food_shop/app/core/utill/url_launcher.dart';

import 'package:food_shop/app/presentations/screen/navigation/mynavigation.dart';
import 'package:food_shop/app/presentations/widget/button/button_widget.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key, required this.transaction}) : super(key: key);

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Center(
              child: Image.asset(
                "assets/image/driver-otw.png",
                width: Get.width * 0.8,
              ),
            ),
            Spacer(),
            Text(
              "You’ve Made Order",
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 10),
            Text(
              "Just stay at home while we are preparing your best foods",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Palette.greyColor),
            ),
            Spacer(),
            ButtonWidget(
                color: Palette.greyColor,
                textColor: Colors.white,
                text: "Payment Method",
                width: 150,
                height: 45,
                onPressed: () =>
                    Launch.openUrl(url: transaction.data!.paymentUrl!)),
            SizedBox(height: 10),
            ButtonWidget(
                text: "Order other foods",
                width: 150,
                height: 45,
                onPressed: () => Get.to(() => MyNavigation())),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
