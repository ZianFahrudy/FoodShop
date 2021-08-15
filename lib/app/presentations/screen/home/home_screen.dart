import 'package:flutter/material.dart';

import '../../../core/component/blocs/food/food_list_bloc.dart';
import '../../../core/injection/injection.dart';
import 'local_widget/food_bar_category.dart';
import 'local_widget/food_list_card.dart';
import 'local_widget/header_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final foodListBloc = getIt<FoodListBloc>();

  @override
  void initState() {
    // foodListBloc.fecthFoodList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            HeaderHome(),
            FoodListCard(),
            FoodBarCategory(),
          ],
        ),
      ),
    );
  }
}
