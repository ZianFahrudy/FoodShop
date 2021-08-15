import 'package:flutter/material.dart';

import 'loader_colors.dart';

class LoaderWidget extends StatelessWidget {
  final String title;
  final Color color;

  const LoaderWidget({
    Key? key,
    required this.title,
    this.color = Colors.teal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.black.withOpacity(0.6),
      width: double.infinity,
      height: size.height,
      child: Center(
        child: Wrap(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 20.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  LoaderColors(
                    color1: Colors.redAccent,
                    color2: Colors.deepPurple,
                    color3: Colors.green,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).primaryTextTheme.button!.copyWith(
                          color: Colors.teal,
                        ),
                  ),
                  const SizedBox(width: 10.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
