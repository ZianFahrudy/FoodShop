import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {Key? key,
      required this.text,
      required this.width,
      required this.height,
      required this.onPressed,
      this.textColor,
      this.color})
      : super(key: key);

  final String text;
  final double width;
  final double height;
  final Color? color;
  final Color? textColor;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            minimumSize: Size(width, height)),
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(context).textTheme.button!.copyWith(color: textColor),
        ));
  }
}
