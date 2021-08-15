import 'package:flutter/material.dart';

import 'loader_colorize.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: ColorLoaderPage(
        dotOneColor: Colors.redAccent,
        dotTwoColor: Colors.blueAccent,
        dotThreeColor: Colors.green,
        dotType: DotType.circle,
        dotIcon: Icon(Icons.adjust),
        duration: Duration(milliseconds: 1000),
      ),
    );
  }
}
