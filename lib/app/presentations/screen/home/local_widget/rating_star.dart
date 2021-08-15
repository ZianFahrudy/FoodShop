import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
  const RatingStar({Key? key, this.rate = 0, this.size = 20}) : super(key: key);

  final int rate;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
          5,
          (index) => index < rate
              ? Icon(
                  Icons.star_rate,
                  color: Colors.yellow,
                  size: size,
                )
              : Icon(
                  Icons.star_rate,
                  color: Theme.of(context).dividerColor,
                  size: size,
                )),
    );
  }
}
