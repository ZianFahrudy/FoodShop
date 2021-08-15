import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_shop/app/core/common/palette.dart';
import 'package:food_shop/app/core/common/size.dart';
import 'package:food_shop/app/core/component/blocs/transaction/checkout/checkout_bloc.dart';
import 'package:food_shop/app/core/component/data/models/request/checkout_body.dart';
import 'package:food_shop/app/core/constant/key_constants.dart';
import 'package:food_shop/app/core/injection/injection.dart';
import 'package:food_shop/app/presentations/widget/appbar/appbar_widget.dart';
import 'package:food_shop/app/presentations/widget/button/button_widget.dart';
import 'package:food_shop/app/presentations/widget/loader/loader_widget.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../payment/payment_screen.dart';
import 'local_widget/deliver_to_card.dart';
import 'local_widget/item_order_card.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    Key? key,
    this.foodName,
    this.price,
    this.picturePath,
    this.quantity,
    required this.foodId,
  }) : super(key: key);

  final String? foodName;
  final int? price;
  final int foodId;
  final String? picturePath;
  final int? quantity;

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final checkouBloc = getIt<CheckoutBloc>();
  final storage = GetStorage();
  int driverFee = 50000;

  @override
  Widget build(BuildContext context) {
    double tax = ((widget.quantity! * widget.price!) + driverFee) * 0.1;
    int totalPrice =
        ((widget.quantity! * widget.price!) + driverFee - tax).toInt();
    onCheckout() {
      checkouBloc.add(OnCheckoutEvent(CheckoutBody(
          foodId: widget.foodId,
          quantity: widget.quantity,
          status: "PENDING",
          total: totalPrice,
          userId: storage.read(KeyConstant.userId))));
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocProvider(
        create: (context) => checkouBloc,
        child: BlocConsumer<CheckoutBloc, CheckoutState>(
            listener: (context, state) {
          if (state is CheckoutFailure) {
            Get.snackbar("Gagal", state.error,
                snackPosition: SnackPosition.TOP,
                backgroundColor: Palette.redColor,
                colorText: Colors.white);
          } else if (state is CheckoutSuccess) {
            Get.snackbar("Berhasil", "Transaksi Berhasill",
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
                backgroundColor: Palette.greenColor);
            Future.delayed(Duration(seconds: 3))
                .then((_) => Get.to(() => PaymentScreen(
                      transaction: state.transaction,
                    )));
          }
        }, builder: (context, state) {
          return SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    AppBarWidget(
                        title: "Payment", subtitle: "You deserve better meal"),
                    ItemOrdercard(
                      driverFee: driverFee,
                      tax: tax,
                      total: totalPrice,
                      foodName: widget.foodName,
                      picturePath: widget.picturePath,
                      price: widget.price,
                      quantity: widget.quantity,
                    ),
                    SizedBox(height: 20),
                    DeliverToCard(),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: Sizes.defaultMargin,
                        right: Sizes.defaultMargin,
                        bottom: 10),
                    child: ButtonWidget(
                        text: "Checkout Now",
                        color: Get.isDarkMode
                            ? Colors.amber
                            : Palette.primaryColor,
                        width: double.infinity,
                        height: 45,
                        onPressed: onCheckout),
                  ),
                ),
                if (state is CheckoutLoading) LoaderWidget(title: "loading")
              ],
            ),
          );
        }),
      ),
    );
  }
}
