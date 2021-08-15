import 'package:flutter/material.dart';
import 'package:food_shop/app/core/component/blocs/transaction/transaction_list/transaction_list_bloc.dart';
import 'package:food_shop/app/core/injection/injection.dart';
import 'package:food_shop/app/presentations/widget/appbar/appbar_widget.dart';
import 'local_widget/order_tab_category.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final transactionBloc = getIt<TransactionListBloc>();
  @override
  void initState() {
    super.initState();
    transactionBloc.fetchTransactionList();
    print('Init Order Screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () async => transactionBloc.fetchTransactionList(),
      child: SafeArea(
          child: ListView(
        children: [
          AppBarWidget(
            isBackIcon: false,
            title: "Your Orders",
            subtitle: "Wait for the best meal",
          ),
          OrderTabBar(transactionListBloc: transactionBloc),
        ],
      )),
    ));
  }
}
