import 'package:flutter/material.dart';

import 'package:food_shop/app/core/component/blocs/transaction/transaction_list/transaction_list_bloc.dart';
import 'package:food_shop/app/core/injection/injection.dart';

import 'package:food_shop/app/presentations/screen/home/home_screen.dart';
import 'package:food_shop/app/presentations/screen/order/order_screen.dart';
import 'package:food_shop/app/presentations/screen/profile/profile_screen.dart';
import 'package:food_shop/app/presentations/widget/bottomnavbar/bottom_navbar_widget.dart';

//ignore: must_be_immutable
class MyNavigation extends StatefulWidget {
  MyNavigation({Key? key, this.index = 0}) : super(key: key);
  int? index;

  @override
  _MyNavigationState createState() => _MyNavigationState();
}

class _MyNavigationState extends State<MyNavigation> {
  final transactionBloc = getIt<TransactionListBloc>();

  onTapItem(int index) {
    setState(() {
      widget.index = index;
    });
  }

  List<Widget> screen = [HomeScreen(), OrderScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        body: IndexedStack(
          index: widget.index!,
          children: screen.map((e) => e).toList(),
        ),
        bottomNavigationBar: BottomNavbarWidget(
            onTapItem: onTapItem, selectedIndex: widget.index!),
      ),
    );
  }
}
