import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    Key? key,
    this.isBackIcon = true,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final bool? isBackIcon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.13,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20),
      color: Theme.of(context).appBarTheme.backgroundColor,
      padding: EdgeInsets.all(20),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isBackIcon!)
            InkWell(
              onTap: () => Get.back(),
              child: Icon(Icons.arrow_back),
            ),
          if (isBackIcon!) SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(subtitle, style: Theme.of(context).textTheme.subtitle2)
            ],
          )
        ],
      ),
    );
  }
}
