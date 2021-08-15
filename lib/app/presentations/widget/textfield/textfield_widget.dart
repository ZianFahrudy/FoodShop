import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {Key? key,
      required this.hintText,
      required this.labelText,
      this.prefixIcon,
      this.suffixIcon,
      this.controller,
      this.obsecureText = false,
      this.textInputAction,
      this.textInputType})
      : super(key: key);

  final String labelText;
  final String hintText;
  final bool? obsecureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText,
            style:
                Theme.of(context).textTheme.headline6!.copyWith(fontSize: 16)),
        SizedBox(height: 5),
        TextFormField(
            obscureText: obsecureText!,
            controller: controller,
            style: Theme.of(context).textTheme.bodyText2,
            keyboardType: textInputType ?? TextInputType.text,
            textInputAction: textInputAction,
            decoration: InputDecoration(
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                hintText: hintText,
                fillColor: Colors.transparent,
                hintStyle: Theme.of(context).textTheme.bodyText2,
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.circular(10)))),
        SizedBox(height: 15),
      ],
    );
  }
}
